# frozen_string_literal: true

class Brand < ApplicationRecord
  has_many :products
  validates :name, presence: true, uniqueness: true
  def self.select_params
    pluck(:name, :id)
  end
end
