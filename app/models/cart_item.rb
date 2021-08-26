# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true
  belongs_to :order, optional: true
  has_one :user, through: :cart
end
