class Admin::CgcSettingsController < Admin::BaseController

  def update
    product = Product.find_by_name("Gift Certificate")

    variant_values = params[:preferences][:values].split(',').inject({}) { |a, v| a['GC $' + ((v.to_f*100).round.to_f/100).to_s] = ((v.to_f*100).round.to_f/100).to_s; a }

    product.variants.each do |variant|
      if !variant_values.has_key? variant.option_values.first.name
        variant.update_attribute(:deleted_at, Time.now)
      end
    end

    option_type = OptionType.find_by_name("gift_cert_increments")
    variant_values.each do |k, v|
      if product.variants.select { |variant| variant.sku == "gift_cert#{v}" }.empty?
        ov = OptionType.find_by_name(k)
        ov = OptionValue.new(:option_type_id => option_type.id, :name => k, :presentation => "$#{v}", :position => 1) if ov.nil?
        ov.save
        variant = Variant.new(:sku => "gift_cert#{v}", :price => v.to_f, :count_on_hand => 1000000, :cost_price => v.to_f, :weight => 0, :product_id => product.id)
        variant.option_values = [ov]
        variant.save
      end
    end
    
    Spree::CouponGiftCertificates::Config.set(params[:preferences])

    respond_to do |format|
      format.html {
        redirect_to admin_cgc_settings_path
      }
    end
  end
end
