FactoryBot.define do
   factory :status do
     name { Faker::Name.name }
     color { Faker::Color.color_name }
     user_id { 1 }
   end
end
