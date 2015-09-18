module Spree
  ProductsController.class_eval do
    after_action :recently_viewed, only: :show

    def recently_viewed
      id = @product.id
      rvp = (cookies['recently_viewed_products'] || '').split(', ')
      rvp.delete(id)
      rvp << id unless rvp.include?(id.to_s)
      rvp_max_count = Spree::RecentlyViewed::Config[:recently_viewed_products_max_count]
      rvp.delete_at(0) if rvp.size > rvp_max_count.to_i
      cookies['recently_viewed_products'] = rvp.join(', ')
    end
  end
end
