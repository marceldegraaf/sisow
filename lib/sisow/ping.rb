module Sisow
  class Ping

    def self.send
      Sisow::Api::PingRequest.perform
    end

  end
end
