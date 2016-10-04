FactoryGirl.define do
  factory :user, aliases: [:suggester] do
    name "User Name"
    sequence(:email_address) { |n| "user#{n}.name@email.com" }
    sequence(:mobile_phone_number) { |n| "123456789#{n}" }    
  end

end
