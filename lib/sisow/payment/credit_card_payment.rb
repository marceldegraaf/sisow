module Sisow
  class CreditCardPayment < Sisow::Payment

    attr_accessor :locale

    def payment_method
      'creditcard'
    end

  end
end
