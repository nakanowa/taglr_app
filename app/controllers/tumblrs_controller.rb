#coding: utf-8
class TumblrsController < ApplicationController
  #include tumblr_request

    def callback 
      session['tumblr_session'] = Tumblr::App::Auth.authenticate(request.env["omniauth.auth"])
      config = TUMBLR_OAUTH_REDIRECT
      redirect_to "/"
    end

    #検索
    def search
      tag_search
    end


    def tag_search
        #TODO:module化
        #response = tag(params[:keyword])
        uri = URI.parse(URI.escape("http://api.tumblr.com/v2/tagged?tag=#{params[:keyword]}&api_key=#{Settings.tumblr.api_key}"))

        @items = MultiJson.load(Net::HTTP.get(uri), :symbolize_keys => true)[:response]

        #logger.debug(@items)

        #responseの中身確認
        #@items.each do |item|
          #logger.debug(item["blog_name"])
        #end

        #情報詰め替え
        #@tags = hoge items
        #logger.debug(@tags).inspect
    end

    #TODO:名前を決める
    #TODO:module?に移動
    #TODO:写真表示用共通の処理にする
    def hoge(items)
      result = Hash.new
      #詰め替え
      items.each do |item| 
        result = {:tags => item["tags"]} if item["tags"]
        logger.debug("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")

        if item["photos"] 
          photo = {}
          item["photos"].each do |photo|
            photo["alt_sizes"].each do |alt| 
              photo = {:width => photo["width"]} if item["width"]
              photo = {:height => photo["height"]} if item["height"]
              photo = {:url => photo["url"]} if item["url"]
            end
            result = {:photos => photo}
          end
        end 
      end
      return result
    end 

    #def create
        #raise request.env["omniauth.auth"].to_yaml  
        #auth = request.env["omniauth.auth"]

        # Twitter.configure do |config|
        # config.consumer_key = 'CONSUMER_KEY'
        # config.consumer_secret = 'CONSUMER_SECRET'
        # config.oauth_token = auth['credentials']['token']
        # config.oauth_token_secret = auth['credentials']['secret']
        # end
    
        # resirect_to リダイレクト先のURL :notice => 'sign in'
    #end




  # def index
  #   if request.get?
  #   else
  #     @keyword = params[:keyword]
  #     res = Amazon::Ecs.item_search(@keyword, {
  #       :search_index => 'Music',
  #       :response_group => 'Medium',
  #       :sort => 'salesrank'
  #     })
  #     @items = []
  #     res.items.each do |item|
  #       @items << Item.new(
  #         item.get('asin'),
  #         item.get('itemattributes/title'),
  #         item.get('detailpageurl'),
  #         item.get_hash('smallimage')
  #       )
  #     end
  #   end
  # end

end
