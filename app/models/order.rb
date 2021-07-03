# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  enum state: { new: 0, failed: 1, completed: 2 }, _prefix: true, _default: :new
end
