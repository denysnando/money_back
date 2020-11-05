# frozen_string_literal: true

class OffersController < CrudController
  before_action do
    use_klass(Offer)
  end

  def new
    super
  end

  def change_status
    @offer = Offer.find(params[:id])

    if @offer.enabled && !@offer.cannot_update_status?
      @offer.update(enabled: false)
      flash[:notice] = 'Update successfully'
    elsif @offer.enabled && @offer.cannot_update_status?
      flash[:error] = 'Unable to update status'
    else
      flash[:notice] = 'Update successfully'
      @offer.update(enabled: true)
    end

    redirect_to offers_path
  end

  protected

  def collection
    super
  end

  private

  def collection_params
    params.require(:offer).permit(:advertiser_name, :url,
                                  :description, :starts_at,
                                  :ends_at, :enabled, :premium)
  end
end
