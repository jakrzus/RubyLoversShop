User.create(email: 'email@example', password: 'password')
AdminUser.create(email: 'admin@example', password: 'password')
3.times do |n|
  category = Category.new(name: "Category#{n}")
  brand = Brand.new(name: "Brand#{n}")

  Category.where(name: category.name).first_or_create(category.as_json)
  Brand.where(name: brand.name).first_or_create(brand.as_json)
end
10.times do |n|
  product = Product.new(name: "Product#{n}",
                        price: rand(1000.01..99999.99).round(2),
                        brand: Brand.all.sample,
                        category: Category.all.sample )
                        
  Product.where(name: product.name).first_or_create(product.as_json)
end