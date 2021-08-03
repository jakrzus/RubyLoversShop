# frozen_string_literal: true

class Shipment < ApplicationRecord
  include AASM

  aasm column: 'state' do
    state :pending, initial: true
    state :ready, :canceled, :shipped, :failed
    event :prepare do
      transitions from: :pending, to: :ready
    end
    event :cancel do
      transitions from: :pending, to: :canceled
      transitions from: :ready, to: :failed
    end
    event :ship do
      transitions from: :ready, to: :shipped, guard: :payment_completed?
    end
  end

  delegate :completed?, to: :payment, prefix: true

  belongs_to :order
  has_one :payment, through: :order
end
