# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class CouponGiftCertificatesExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/coupon_gift_certificates"

  # Please use coupon_gift_certificates/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    Admin::ReportsController.send(:include, Spree::CouponGiftCertificates::ReportsController)
    Order.send(:include, Spree::CouponGiftCertificates::Order)
    Product.send(:include, Spree::CouponGiftCertificates::Product)
  
    LineItem.class_eval do
      has_one :line_item_coupon
      has_one :coupon, :through => :line_item_coupon
    end

    Coupon.class_eval do
      has_one :line_item_coupon
      has_one :line_item, :through => :line_item_coupon
    end
  end
end
