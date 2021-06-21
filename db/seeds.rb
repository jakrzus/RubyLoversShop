require 'uri'
User.create(email: 'email@example', password: 'password')
AdminUser.create(email: 'admin@example', password: 'password')
3.times do 
  category = Category.new(name: Faker::Vehicle.unique.car_type)
  brand = Brand.new(name: Faker::Vehicle.unique.make)

  Category.where(name: category.name).first_or_create(category.as_json)
  Brand.where(name: brand.name).first_or_create(brand.as_json)
end
15.times do
  file = URI.open(Faker::Avatar.image)
  product = Product.new(name: Faker::Vehicle.unique.model,
                        price: rand(1000.01..99999.99).round(2),
                        brand: Brand.all.sample,
                        category: Category.all.sample )
                        
  product = Product.where(name: product.name).first_or_create(product.as_json)
  product.photos.attach io: file, filename: "carphoto.jpg", content_type: 'image/jpg'
  
end
