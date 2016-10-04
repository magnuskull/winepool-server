FactoryGirl.define do
  factory :wine do
    name "Barolo"
    description "Medium+ acidity, well balanced. Needs age."
    bottles 6
    price 179
    association :suggester, strategy: :build
  end

end
