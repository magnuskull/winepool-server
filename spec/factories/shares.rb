FactoryGirl.define do
  factory :share do
    association :user, strategy: :build
    association :wine, strategy: :build
    amount 2
  end

end
