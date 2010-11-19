# Coupon Gift Certificates

This extension utilizes Spree's existing coupon system for gift certificates. The gift certificates in this extension apply to items, tax and shipping.

This extension works with Spree 0.10 and 0.11 versions.

## Potential integration points for this extension include:
* order confirmation mailer updates to include gift certificate information
* additional form for gift certificate submission
* navigation updates to include gift certificate product

## To insert order mailers, include:
* <%= render :partial => '/order_mailer/gift_certificate.plain.erb' %> in text order confirmation template
* <%= render :partial => '/order_mailer/gift_certificate.html.erb' %> in html order confirmation template

## To insert special form, include:
<%= render :partial => 'gift_certificate_form' if @checkout.state == 'payment' %> in the checkouts/edit template
* Note that this must not be INSIDE the payment checkout form
