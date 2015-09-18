module Spree
  module Admin
    GeneralSettingsController.class_eval do

      before_action :save_recently_viewed, only: :update

      private

      def save_recently_viewed
        if params[:viewed_products_max_count]
          Spree::RecentlyViewed::Config[:recently_viewed_products_max_count] = params[:viewed_products_max_count]
        end
      end
    end
  end
end