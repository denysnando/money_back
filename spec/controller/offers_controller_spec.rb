# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OffersController, type: :controller do
  let!(:user) { create(:user) }
  let(:valid_attributes) do
    {
      offer: {
        advertiser_name: 'Google',
        url: 'http://google.com.br',
        description: 'Google Corporation discount',
        starts_at: '24/05/2020'
      }
    }
  end

  describe '#index' do
    context 'with render index' do
      before do
        sign_in user
      end

      it 'does not create' do
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'with search params set' do
      before do
        sign_in user
        create(:offer, advertiser_name: 'AMAZON', enabled: true)
        create(:offer, advertiser_name: 'GOOGLE', enabled: true)
      end

      it 'shoulda render just one offer' do
        get :index, params: {filter: { term: 'GOOGLE' } }

        expect(response).to render_template('index')
        assigns(:collections).size.should == 1
      end
    end
  end

  describe '#new' do
    context 'with valid attributes' do
      before do
        sign_in user
      end

      it 'does not create' do
        get :new
        expect(response).to render_template('new')
      end
    end
  end

  describe '#edit' do
    let(:offer) { create(:offer) }

    context 'with valid attributes' do
      before do
        sign_in user
      end

      it 'should return template edit' do
        get :edit, params: { id: offer.id }
        expect(response).to render_template('edit')
      end
    end
  end

  describe '#create' do
    context 'when not signed_in' do
      context 'with valid attributes' do
        it 'does not create' do
          expect { post :create, params: valid_attributes }.not_to change(Offer, :count)
        end

        it 'redirets to login' do
          expect(post(:create, params: valid_attributes)).to redirect_to(new_user_session_path)
        end
      end
    end

    context 'when signed_in' do
      context 'with valid attributes' do
        before do
          sign_in user
        end

        it 'shoulda create a new offer' do
          expect { post :create, params: valid_attributes }.to change(Offer, :count).by(1)
        end

        it 'shoulda redirect to admin page' do
          expect(post(:create, params: valid_attributes)).to redirect_to(offers_path)
        end
      end

      context 'with invalid attributes' do
        let(:offer) { create(:offer, advertiser_name: 'AMAZON') }

        it 'shoulda not create a new offer' do
          expect { post :create, params: valid_attributes }.not_to change(Offer, :count)
        end
      end
    end
  end

  describe '#update' do
    let(:offer) { create(:offer) }

    context 'when signed_in' do
      before do
        sign_in user
      end

      it 'when offer update' do
        params = { id: offer.id, offer: { advertiser_name: 'AMAZON' } }
        put :update, params: params

        expect(offer.reload.advertiser_name).to eq('AMAZON')
      end
    end

    context 'when not signed in' do
      it 'shoulda not allow user access' do
        params = { id: offer.id, offer: { advertiser_name: 'AMAZON' } }
        put :update, params: params

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE' do
    let!(:offer) { create(:offer) }

    context 'when signed_in' do
      before do
        sign_in user
      end

      context 'when offer exists' do
        it 'shoulda destroy' do
          expect { delete :destroy, params: { id: offer.id } }.to change(Offer, :count).by(-1)
        end
      end
    end
  end

  describe '#change_status' do
    let(:offer) { create(:offer, starts_at: Time.zone.now - 3.hours) }
    let(:offer_2) { create(:offer, starts_at: Time.zone.now - 3.days, enabled: true, ends_at: Time.zone.now - 2.days) }
    let(:offer_3) { create(:offer, enabled: true) }

    context 'when signed_in' do
      before do
        sign_in user
      end

      context 'when offer can be enabled' do
        it 'shoulda enable' do
          put :change_status, params: { id: offer.id }

          expect(offer.reload.enabled).to be_truthy
          expect(flash[:notice]).to eq('Update successfully')
        end
      end

      context 'when offer cant be disable' do
        it 'shoulda does not disabled' do
          put :change_status, params: { id: offer_2.id }

          expect(offer_2.reload.enabled).to be_truthy
          expect(flash[:error]).to eq('Unable to update status')
        end
      end

      context 'when offer can be disable' do
        it 'shoulda disabled' do
          put :change_status, params: { id: offer_3.id }

          expect(offer_3.reload.enabled).to be_falsey
          expect(flash[:notice]).to eq('Update successfully')
        end
      end
    end
  end
end
