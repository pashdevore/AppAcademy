require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @req = req
      @cookies_hash = {}
      @lite_app = {}
      req.cookies.each do |cookie|
        if cookie.name == '_rails_lite_app' && cookie.value
          @lite_app = JSON.parse(cookie.value)
        end
      end
    end

    def [](key)
      @lite_app[key]
    end

    def []=(key, val)
      @lite_app[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies << WEBrick::Cookie.new("_rails_lite_app", @lite_app.to_json)
    end
  end
end
