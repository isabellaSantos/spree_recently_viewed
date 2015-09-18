require 'spec_helper'

describe 'Recently Viewed Settings', { type: :feature, js: true } do

  let!(:user) { create(:admin_user) }

  before do
    visit '/admin'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

  it 'should save the max quantity of products' do
    visit spree.edit_admin_general_settings_path

    fill_in 'viewed_products_max_count', with: '2'
    click_button 'Update'

    expect(Spree::RecentlyViewed::Config[:recently_viewed_products_max_count]).to eq 2
  end

end