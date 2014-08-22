require 'omniauth-oauth'
require 'multi_json'

module tumblr_request

      def serch(tag)
        url = 'http://api.tumblr.com/v2/tagged?tag=#{tag}&api_key=#{Settings.tumblr.api_key}'
        @raw_info ||= MultiJson.decode(access_token.get(url).body)['response']
      end
    
end