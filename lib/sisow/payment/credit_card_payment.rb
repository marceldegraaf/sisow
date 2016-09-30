module Sisow
  class CreditCardPayment < Sisow::Payment

    def payment_method
      'creditcard'
    end

  end
end
