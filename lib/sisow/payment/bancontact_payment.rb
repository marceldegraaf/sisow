module Sisow
  class BancontactPayment < Sisow::Payment

    def payment_method
      'mistercash'
    end

  end
end
