require "grape"
require "peddler"

module Pricing
  class API < Grape::API
    version "v1", using: :path
    format :json

    get :status do
      {message: "its up"}
    end

    desc "isbn/upc endpoint"
    params do
      requires :isbn, type: String, desc: "ISBN-10"
    end
    route_param :isbn do
      get do
        begin
          client = MWS.products
          listing = client.get_matching_product_for_id("ISBN", *["#{params[:isbn]}"])
          asin = listing.parse["Products"] ? listing.parse["Products"]["Product"].first["Identifiers"]["MarketplaceASIN"]["ASIN"].to_s : ""
          return {status: "fail", message: "invalid isbn"} if asin.blank?
          competitive = nil
          lowest = nil
          c = Thread.new do
            competitive = client.get_competitive_pricing_for_asin(*[asin])
          end
          l = Thread.new do
            lowest = client.get_lowest_offer_listings_for_asin(*[asin])
          end
          c.join
          l.join
          {status: "done", message: "ok", listing: listing.parse, competitive: competitive.parse, lowest: lowest.parse}
        rescue Excon::Errors::HTTPStatusError => e
          {status: "fail", message: "http status error", data: e.inspect}
        end
      end
    end
  end
end
