# frozen_string_literal: true

class Offer < ApplicationRecord
  # Validates
  validates :advertiser_name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :url, url: { public_suffix: true }
  validates :starts_at, presence: true, date: true
  validates :ends_at, date: { allow_blank: true, after_or_equal_to: :starts_at}

  def cannot_update_status?
    ends_at.nil? || Time.zone.today > ends_at
  end
end
