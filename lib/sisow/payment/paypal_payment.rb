module Sisow
  class PaypalPayment < Sisow::Payment

    attr_accessor :locale

    def payment_method
      'paypalec'
    end

  end
end
