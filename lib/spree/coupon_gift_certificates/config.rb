module Spree::CouponGiftCertificates
  class Config
    # Singleton class to access the google base configuration object (CouponGiftCertificatesConfiguration.first by default) and it's preferences.
    #
    # Usage:
    #   Spree::CouponGiftCertificates::Config[:foo]                    # Returns the foo preference
    #   Spree::CouponGiftCertificates::Config[]                        # Returns a Hash with all the google base preferences
    #   Spree::CouponGiftCertificates::Config.instance                 # Returns the configuration object (CouponGiftCertificatesConfiguration.first)
    #   Spree::CouponGiftCertificates::Config.set(preferences_hash)    # Set the google base preferences as especified in +preference_hash+
    include Singleton
    include PreferenceAccess

    class << self
      def instance
        return nil unless ActiveRecord::Base.connection.tables.include?('configurations')
        CouponGiftCertificatesConfiguration.find_or_create_by_name("Default product reviews and ratings configuration")
      end
    end
  end
end

