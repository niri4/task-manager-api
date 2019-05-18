FactoryBot.define do
   factory :task do
     name {Faker::Name.name}
     description {Faker::Name.last_name}
     due_date { Date.today }
   end
end
