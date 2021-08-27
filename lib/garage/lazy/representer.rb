require 'active_support/concern'
require 'garage/representer'

module Garage
  module Lazy
    module Representer
      extend ActiveSupport::Concern

      def ensure_promises(options = {})
        field_selector = options[:selector] || selector
        representer_attrs.each do |definition|
          if definition.lazy? && handle_definition?(field_selector, definition, options)
            definition.ensure_promise(self, field_selector[definition.name])
          end
        end
      end

      class Garage::Representer::Definition
        def lazy?
          false
        end
      end

      class Garage::Representer::Collection
        def lazy?
          false
        end
      end

      class Garage::Representer::Link
        def lazy?
          false
        end
      end

      class LazyDefinition < Garage::Representer::Definition
        def promise(object)
          object.public_send(@name)
        end

        def ensure_promise(object, selector = nil)
          batch_promise = promise(object)
          unless batch_promise.is_a?(Promise)
            raise TypeError, "#{@name} must be wrapped Promise object for lazy loading"
          end

          batch_promise.then do |resource|
            if resource.is_a?(Garage::Lazy::Representer)
              resource.represent! unless resource.representer_attrs
              resource.ensure_promises(selector: selector)
            end
          end
        end

        def encode(object, responder, selector = nil)
          value = promise(object).sync
          encode_value(value, responder, selector)
        end

        def lazy?
          true
        end
      end

      class LazyCollection < Garage::Representer::Collection
        def promise(object)
          object.public_send(@name)
        end

        def ensure_promise(object, selector = nil)
          batch_promise = promise(object)
          unless batch_promise.is_a?(Promise)
            raise TypeError, "#{@name} must be wrapped Promise object for lazy loading"
          end

          batch_promise.then do |resources|
            resources.each do |resource|
              if resource.is_a?(Garage::Lazy::Representer)
                resource.represent! unless resource.representer_attrs
                resource.ensure_promises(selector: selector)
              end
            end
          end
        end

        def encode(object, responder, selector = nil)
          values = promise(object).sync
          values.map do |value|
            encode_value(value, responder, selector)
          end
        end

        def lazy?
          true
        end
      end

      module ClassMethods
        def lazy_property(name, options={})
          representer_attrs << LazyDefinition.new(name, options)
        end

        def lazy_collection(name, options={})
          representer_attrs << LazyCollection.new(name, options)
        end
      end
    end
  end
end
