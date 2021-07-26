# frozen_string_literal: true

class Order < ApplicationRecord
  STATES = %w[new failed completed].freeze

  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  has_one :payment, dependent: :destroy
  has_one :shipment, dependent: :destroy

  enum state: STATES, _prefix: true, _default: :new

  delegate :state, to: :payment, prefix: 'payment'
  delegate :state, to: :shipment, prefix: 'shipment'
  delegate :email, to: :user, prefix: 'user'

  before_create :build_payment
end
