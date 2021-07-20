class Shipment < ApplicationRecord
  include AASM

  aasm :column => 'state' do
  end
  belongs_to :order
end
