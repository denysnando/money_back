# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :advertiser_name }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_url_of(:url) }
    it { is_expected.to validate_presence_of :starts_at }
  end

  context 'validates uniqueness' do
    it { is_expected.to validate_uniqueness_of(:advertiser_name) }
  end

  context 'validates length' do
    it { is_expected.to validate_length_of(:description).is_at_most(500) }
  end
end
