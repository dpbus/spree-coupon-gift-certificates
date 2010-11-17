class CouponGiftCertificateMigration < ActiveRecord::Migration
  def self.up
    create_table :line_item_coupons do |t|
      t.column :line_item_id, :integer, :null => false
      t.column :coupon_id, :integer, :null => false
    end 

    option_type = OptionType.new(:name => "gift_cert_increments", :presentation => "Amount")
    option_type.save
    o25 = OptionValue.new(:option_type_id => option_type.id, :name => "GC $25", :presentation => "$25", :position => 1)
    o25.save
    o50 = OptionValue.new(:option_type_id => option_type.id, :name => "GC $50", :presentation => "$50", :position => 1)
    o50.save

    product = Product.new(:name => "Gift Certificate", :description => "Gift Certificate", :available_on => Time.now, :permalink => "gift-certificate", :count_on_hand => 1000000, :price => 25.00)
    product.option_types = [option_type]
    product.save
    v25 = Variant.new(:sku => "gift_cert25", :price => 25.00, :count_on_hand => 1000000, :cost_price => 25.00, :weight => 0, :product_id => product.id)
    v25.option_values = [o25]
    v25.save
    v50 = Variant.new(:sku => "gift_cert50", :price => 50.00, :count_on_hand => 1000000, :cost_price => 50.00, :weight => 0, :product_id => product.id)
    v50.option_values = [o50]
    v50.save

    Property.create(:name => "gift_cert", :presentation => "Gift Certificate", :created_at => Time.now)
    ProductProperty.create(:product_id => product.id, :value => 1, :property_id => Property.find_by_name("gift_cert").id)
  end

  def self.down
    drop_table :line_item_coupons

    Variant.delete(Product.find_by_name("Gift Certificate").variants)
    ProductProperty.delete(Product.find_by_name("Gift Certificate").properties)
    Product.find_by_name("Gift Certificate").delete
    Property.find_by_name("gift_cert").delete

    OptionValue.delete(OptionType.find_by_name("gift_cert_increments").option_values)
    OptionType.find_by_name("gift_cert_increments").delete
  end
end
