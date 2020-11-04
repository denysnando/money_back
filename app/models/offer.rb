# frozen_string_literal: true

class Offer < ApplicationRecord
  # Validates
  validates :advertiser_name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :url, presence: true, url: true
  validates :starts_at, presence: true

end