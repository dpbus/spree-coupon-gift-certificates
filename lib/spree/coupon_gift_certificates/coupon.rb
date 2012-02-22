module Spree::CouponGiftCertificates::Coupon
  def self.included(model)
    model.class_eval do
      alias :spree_eligible? :eligible?
      def eligible?(order); cgc_eligible?(order); end
    end
  end
 
  def cgc_eligible?(order)
    increments = OptionType.find_by_name("gift_cert_increments").option_values.map {|v| v.name.split("$").last }
    gc_regex = Regexp.new("^RT[#{increments.join('|')}]\d{4,}")
    
    return false if expires_at and Time.now > expires_at
    return false if usage_limit and coupon_credits.with_order.count >= usage_limit
    return false if starts_at and Time.now < starts_at
    return false if code =~ gc_regex && calculator.preferred_amount == 0
    true
  end
end
