class CouponGiftCertificatesHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_configurations_menu, 'admin/cgc_settings/config_menu'
end
