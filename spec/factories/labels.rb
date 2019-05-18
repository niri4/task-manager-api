FactoryBot.define do
   factory :label do
     name {Faker::Name.name}
     color { Faker::Color.color_name }
   end
end
