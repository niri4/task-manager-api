FactoryBot.define do
   factory :status do
     name { Faker::Name.name }
     color { Faker::Color.color_name }
   end
end
