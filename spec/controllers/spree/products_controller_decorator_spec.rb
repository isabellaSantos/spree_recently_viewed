require 'spec_helper'

describe Spree::ProductsController, type: :controller do

  let!(:product_1) { create(:product) }
  let!(:product_2) { create(:product) }
  let!(:product_3) { create(:product) }

  context 'recently_viewed' do

    it 'should add a cookie with id of visited product' do
      get :show, id: product_1.to_param
      expect(cookies['recently_viewed_products']).to eq(product_1.id.to_s)
    end

    it 'should add all products to a cookie' do
      get :show, id: product_1.to_param
      get :show, id: product_2.to_param

      expect(cookies['recently_viewed_products']).to eq("#{product_1.id}, #{product_2.id}")
    end

    it 'should only storage the quantity of product saved in settings' do
      Spree::RecentlyViewed::Config[:recently_viewed_products_max_count] = 2
      get :show, id: product_1.to_param
      get :show, id: product_2.to_param
      get :show, id: product_3.to_param

      expect(cookies['recently_viewed_products']).to eq("#{product_2.id}, #{product_3.id}")
    end
  end
end