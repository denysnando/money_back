# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :user_type }
    it { is_expected.to validate_presence_of :email }
  end

  context 'when validates uniqueness' do
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end
end
