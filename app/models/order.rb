# frozen_string_literal: true

class Order < ApplicationRecord
  STATES = %w[new failed completed].freeze

  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  enum state: STATES, _prefix: true, _default: :new
end
