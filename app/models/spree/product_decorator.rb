module Spree
  Product.class_eval do
    def self.find_by_array_of_ids(ids)
      products = Spree::Product.where('id IN (?)', ids)
      ids.map { |id| products.detect { |product| product.id == id.to_i } }.compact
    end
  end
end
