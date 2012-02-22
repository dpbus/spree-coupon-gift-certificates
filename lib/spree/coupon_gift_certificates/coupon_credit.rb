module Spree::CouponGiftCertificates::CouponCredit
  def self.included(model)
    model.class_eval do
      alias :spree_calculate_coupon_credit :calculate_coupon_credit
      def calculate_coupon_credit; cgc_calculate_coupon_credit; end
    end
  end

  def cgc_calculate_coupon_credit
    increments = OptionType.find_by_name("gift_cert_increments").option_values.map {|v| v.name.split("$").last }
    gc_regex = Regexp.new("^RT[#{increments.join('|')}]\d{4,}")
    
    return 0 if order.line_items.empty?
    amount = adjustment_source.calculator.compute(order.line_items).abs
    order_total = adjustment_source.code =~ gc_regex ? order.item_total + order.charges.total : order.item_total
    amount = order_total if amount > order_total
    -1 * amount
  end 
end
