module Spree::CouponGiftCertificates::CheckoutsController
  def self.included(controller)
    controller.class_eval do
      alias :spree_load_available_payment_methods :load_available_payment_methods
      def load_available_payment_methods; cgc_load_available_payment_methods; end
    end
  end

  def cgc_load_available_payment_methods
    @payment_methods = PaymentMethod.available(:front_end)

    if object.order.total > 0
      @payment_methods = @payment_methods.select { |pm| pm.name != 'Gift Certificate' }
      if @checkout.payment and @checkout.payment.payment_method and @payment_methods.include?(@checkout.payment.payment_method)
        @payment_method = @checkout.payment.payment_method
      else
        @payment_method = @payment_methods.first
      end
    else
      @payment_methods = @payment_methods.select { |pm| pm.name == 'Gift Certificate' }
      @payment_method = @payment_methods.first
    end
  end
end
