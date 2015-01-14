require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = {}


      unless req.query_string.nil?
        parse_www_encoded_form(req.query_string).each do |key, value|
          @params[key] = value
        end
      end

      unless req.body.nil?
        parse_www_encoded_form(req.body).each do |key, value|
          @params[key] = value
        end
      end

      unless route_params.nil?
        route_params.each do |key, value|
          @params[key] = value
        end
      end
    end

    def [](key)
      @params[key]
    end

    def to_s
      @params.to_json.to_s
    end

    # class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      params = {}
      key_value_chunks = URI.decode_www_form(www_encoded_form)

      # currently key for user[addr][street]=main => [["user[address][street]", "main"]]
      # we want {"user" => { "addr" => { "street" => "encanto" } } }

      key_value_chunks.each do |key_blob, value|
        current_node = params

        # [["user[address][street]", "main"]] => ["user", "address", "street"]
        key_array = parse_key(key_blob)

        key_array.each_with_index do |key, index|
          if index == key_array.count - 1
            current_node[key] = value
          else
            current_node[key] ||= {}
            current_node = current_node[key]
          end
        end
      end

      params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\[|\]\[|\]/)
    end
  end
end
