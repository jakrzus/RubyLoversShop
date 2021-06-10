# frozen_string_literal: true

module Helpers
  def fill_in_sign_in_form_as(user)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
  end

  def fill_in_sign_up_form_as(user)
    fill_in_sign_in_form_as user
    fill_in 'Password confirmation', with: user.password
  end

  def log_in(user)
    post user_session_path, params: { user: { email: user.email, password: user.password } }
    follow_redirect!
  end

  def log_in_admin(admin)
    post admin_user_session_path, params: { admin_user: { email: admin.email, password: admin.password } }
    follow_redirect!
  end

  def fill_in_product_form(product)
    fill_in 'Name',	with: product.name
    fill_in 'Price',	with: product.price
    select product.category.name, from: 'product_category_id'
    select product.brand.name, from: 'product_brand_id'
  end

  def login_admin
    admin = create :admin_user
    visit admin_root_path
    fill_in_sign_in_form_as admin
    click_on 'Log in'
  end

  RSpec.configure do |config|
    config.include Helpers
  end
end
