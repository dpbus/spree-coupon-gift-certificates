module Spree::CouponGiftCertificates::ReportsController
  def self.included(target)
    target.class_eval do
      alias :spree_index :index
      def index; cgc_index; end
    end
  end

  def cgc_index
    @reports = {
      :gift_certificates => { :name => "Gift Certificates", :description => "Gift Certificates" }
    }.merge(Admin::ReportsController::AVAILABLE_REPORTS)
  end

  def gift_certificates
    @coupons = Coupon.find(:all, :conditions => "code LIKE 'giftcert%'")
    # amount used 
    # amount available
    # link to order(s) applied to 
  end
end
