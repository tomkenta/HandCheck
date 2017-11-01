class API < Grape::API
  #prifix 'api'
  version 'v1', using: :path
  format :json

  helpers do
    def check
      # hand = Hand.new(params[:s_hands])
      # {
      #   card: params[:s_hands],
      #   hand: hand.check,
      #   best: false
      # }
      res_arr = []
      params[:cards].each do |hand|
        res_arr << {
          "card": hand,
          "hand": Hand.new(hand).check,
          "best": false
        }
      end
      {"result": res_arr}
    end

    def err401
      error!('401 Unauthorized', 401)
    end
  end

  resource :cards do

    get :check do
      check if params[:cards].present?
    end

    post :check do
      check if params[:cards].present?
    end
    get :secret do
      err401
    end
  end
end