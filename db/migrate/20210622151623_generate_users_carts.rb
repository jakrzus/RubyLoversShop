class GenerateUsersCarts < ActiveRecord::Migration[6.1]
  def change
    User.find_each &:create_cart
  end
end
