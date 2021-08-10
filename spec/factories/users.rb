FactoryBot.define do
  factory :user do
    sequence :email do |i|
      "user-#{i}@example.com"
    end
    password { 'dummy' }
    sequence :username do |i|
      "user-#{i}"
    end
  end
end
