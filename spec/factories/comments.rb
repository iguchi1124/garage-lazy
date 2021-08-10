FactoryBot.define do
  factory :comment do
    user
    article
    body  do
      <<~BODY
        This is article comment
      BODY
    end
  end
end
