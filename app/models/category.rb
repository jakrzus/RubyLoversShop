# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_exception
  validates :name, presence: true, uniqueness: true

  def self.select_params
    pluck(:name, :id)
  end
end
