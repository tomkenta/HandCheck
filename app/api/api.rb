class API < Grape::API
  #prifix 'api'
  version 'v1', using: :path
  content_type :json, "application/json"
  format :json

  helpers do
    def check
      res_arr = []
      hands   = []

      params[:cards].each do |s_hand|
        hands << Hand.new(s_hand)
      end
      hands.each do |hand|
        res_arr << {
          "card": hand.string,
          "hand": (hand.valid?) ? hand.check[:name] : 'invalid',
          #"best": hands.all? {|e| hand.is_stronger_than_or_eqaul(e)}
          "best": hands.all? {|e| hand.check[:power] >= e.check[:power]}
        }
      end
      { "result": res_arr }
    end

    def err401
      error!('401 Unauthorized, Use POST with param {"card" : [H1 H3 H2 H4 H5], ....}', 401)
    end
  end

  resource :cards do

    get :check do
      err401
    end

    post :check do
      check if params[:cards].present?
    end

    get :secret do
      err401
    end
  end

  route :any, '*path' do

    @http_method  = request.request_method
    @request_path = request.url

    error!("#{@http_method}: #{@request_path} is not Found (404)", 404)
  end

  # Grapeの例外の場合は400を返す
  rescue_from Grape::Exceptions::Base do |e|
    error!(e.message, 400)
  end

  # それ以外は500
  rescue_from :all do |e|
    error!({ error: e.message, backtrace: e.backtrace[0] }, 500)
  end
end