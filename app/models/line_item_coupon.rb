class LineItemCoupon < ActiveRecord::Base
  belongs_to :line_item
  belongs_to :coupon
 
  validates_presence_of :line_item_id
  validates_presence_of :coupon_id
end
