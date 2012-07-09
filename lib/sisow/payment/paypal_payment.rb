module Sisow
  class PaypalPayment < Sisow::Payment

    def payment_method
      'paypalec'
    end

  end
end
