module Spree::CouponGiftCertificates::Product
  def is_gift_cert?
    product_properties.any? { |product_property| product_property.property.name == 'gift_cert' && product_property.value }
  end
end
