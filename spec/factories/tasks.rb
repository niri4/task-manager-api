FactoryBot.define do
   factory :task do
     name {Faker::Name.name}
     description {Faker::Name.last_name}
     due_date { Date.today }
     status_id { 1 }
     label_id { 1 }
     user_id { 1 }
   end
end
