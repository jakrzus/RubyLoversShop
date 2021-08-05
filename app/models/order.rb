# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM
  STATES = %w[new failed completed].freeze

  aasm column: 'state' do
    state :new, initial: true
    state :failed, :completed
    event :cancel do
      transitions from: :new, to: :failed
    end
    event :complete do
      transitions from: :new, to: :completed, guard: :completion_permitted?
    end
  end

  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  has_one :payment, dependent: :destroy
  has_one :shipment, dependent: :destroy

  enum state: STATES, _prefix: true

  delegate :state, to: :payment, prefix: 'payment'
  delegate :state, to: :shipment, prefix: 'shipment'
  delegate :email, to: :user, prefix: 'user'

  def completion_permitted?
    payment.completed? && shipment.shipped?
  end
  before_create :build_payment, :build_shipment
end
