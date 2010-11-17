# map.gift_cert "/gift-certificates", :controller => 'products', :action => :show, :id => Product.find_by_permalink('gift-certificate')

map.namespace :admin do |admin|
  admin.resources :reports, :collection => { :cgc => :get }
  admin.resource :cgc_settings
end
