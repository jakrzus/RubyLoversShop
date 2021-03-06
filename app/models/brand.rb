# frozen_string_literal: true

class Brand < ApplicationRecord
  has_many :products, dependent: :restrict_with_exception
  validates :name, presence: true, uniqueness: true
end
