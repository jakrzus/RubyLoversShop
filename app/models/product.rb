# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.0 }, presence: true
  has_many_attached :photos
  belongs_to :category
  belongs_to :brand
  has_many :cart_items, dependent: :restrict_with_exception

  scope :filtered, ->(params) { params ? where(params.compact_blank) : all }
end
