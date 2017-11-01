class API < Grape::API
  #prifix 'api'
  version 'v1', using: :path
  format :json

  helpers do
    def check
      res_arr = []
      hands = []

      params[:cards].each do |s_hand|
        hands << Hand.new(s_hand)
      end
      hands.each do |hand|
        res_arr << {
          "card": hand.to_string,
          "hand": hand.check[:name],
          "best": hands.all? {|e| hand.is_stronger_than_or_eqaul(e)}
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