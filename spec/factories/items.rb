FactoryGirl.define do
  factory :item do
    name { Faker::Lorem.sentence }
    done false
    bucketlist
  end
end
