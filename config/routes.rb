map.namespace :admin do |admin|
  admin.resource :cgc_settings
end

# TODO: Later
# map.gift_cert "/gift-certificates", :controller => 'products', :action => :show, :id => Product.find_by_permalink('gift-certificate')
