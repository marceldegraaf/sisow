module Sisow
  class SofortPayment < Sisow::Payment

    def payment_method
      'sofort'
    end

  end
end
