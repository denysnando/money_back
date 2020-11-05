# frozen_string_literal: true

class HomepageController < ApplicationController
  layout 'home_layout'
  skip_before_action :authenticate_user!

  def index
    @offers = Offer.enabled
  end
end
