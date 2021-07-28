# frozen_string_literal: true

class Payment < ApplicationRecord
  include AASM

  aasm column: 'state' do
    state :pending, initial: true
    state :failed, :completed
    event :cancel do
      transitions from: :pending, to: :failed
    end
    event :complete do
      transitions from: :pending, to: :completed
    end
  end
  belongs_to :order
end
