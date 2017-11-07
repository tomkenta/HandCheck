  require 'rails_helper'

  RSpec.describe HandsController, type: :controller do

    describe "GET #index" do
      context 'ポーカーのカードを入力したとき' do
        before do
        get :index, params:{s_hands:"H1 H2 H3 H4 H5"}
        end
        it "@リクエストは200 okになること" do
          expect(response.status).to eq 200
        end
        it "@handsに,新規オブジェクトが格納されていること" do

        end

        it ":indexテンプレートが表示されること" do
          expect(response).to render_template :index
        end

      end
    end
  end
