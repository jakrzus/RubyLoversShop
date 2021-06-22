class GenerateUsersCarts < ActiveRecord::Migration[6.1]
  def change
    User.all.each(&:create_cart)
  end
end
