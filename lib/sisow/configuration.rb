module Sisow
  class Configuration

    attr_accessor :merchant_id, :merchant_key, :test_mode, :debug_mode, :shop_id

    def initialize
      @debug_mode   = false
      @test_mode    = false
      @merchant_key = nil
      @merchant_id  = nil
      @shop_id      = nil
    end

    def test_mode_enabled?
      @test_mode == true
    end

    def debug_mode=(boolean)
      @debug_mode = boolean

      if boolean == true
        Sisow::Api::Request.debug_output $stderr
      else
        Sisow::Api::Request.debug_output nil
      end
    end

    def debug_mode_enabled?
      @debug_mode == true
    end

  end
end
