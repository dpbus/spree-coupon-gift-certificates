class CouponGiftCertificatesExtension < Spree::Extension
  version "1.0"
  description "Gift Certificates via Coupons"
  url "http://www.endpoint.com/"

  def activate
    Order.send(:include, Spree::CouponGiftCertificates::Order)
    Product.send(:include, Spree::CouponGiftCertificates::Product)
    Coupon.send(:include, Spree::CouponGiftCertificates::Coupon)
    CouponCredit.send(:include, Spree::CouponGiftCertificates::CouponCredit)
    CheckoutsController.send(:include, Spree::CouponGiftCertificates::CheckoutsController)
  
    LineItem.class_eval do
      has_many :line_item_coupon
      has_many :coupons, :through => :line_item_coupon
    end

    Coupon.class_eval do
      has_one :line_item_coupon
      has_one :line_item, :through => :line_item_coupon
    end

    [
      PaymentMethod::GiftCertificate
    ].each{|gw|
      begin
        gw.register
      rescue Exception => e
        $stderr.puts "Error registering gateway #{gw}: #{e}"
      end
    }
  end
end
