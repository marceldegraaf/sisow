module Sisow
  class IdealPayment < Sisow::Payment

    def payment_method
      'ideal'
    end

  end
end
