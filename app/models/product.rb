# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.0 }
  has_many_attached :photos
  belongs_to :category
  belongs_to :brand

  scope :filtered, ->(params) { params ? where(params.compact_blank) : all }
end
