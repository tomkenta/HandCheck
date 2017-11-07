require 'rails_helper'

RSpec.describe HandsController, type: :controller do

  describe "GET #index" do

    context "カードが入力されていない場合" do
      before do
        get :index
      end

      example "@リクエストは200 okになること" do
        expect(response.status).to eq 200
      end

      example "@handsにインスタンスは入らない" do
        expect(assigns(:hands)).to be nil
      end
      example "同じ画面に戻る" do
        expect(response).to render_template :index
      end
    end


    context "カードが入力されている場合" do
      context "値が期待した値以外" do
        before do
          get :index, params: { s_hands: "hogehoge" }
        end
        example "validationが動いて弾く" do
          expect(assigns(:hands).valid?).to eq false;
        end
      end
      context "値が期待した値以外（マーク）" do
        before do
          get :index, params: { s_hands: "H1 H3 H5 H9 A10" }
        end

        example "validationが動いて弾く" do
          expect(assigns(:hands).valid?).to eq false;
        end
      end
      context "値が期待した値以外（数字）" do
        before do
          get :index, params: { s_hands: "H1 H3 H5 H14 H10" }
        end

        example "validationが動いて弾く" do
          expect(assigns(:hands).valid?).to eq false;
        end
      end
    end

    context "値が期待した値" do
      before do
        get :index, params: { s_hands: "H1 H2 H3 H4 H5" }
      end
      example "カードの役が表示される" do
        expect(assigns(:hands).check[:name]).to eq "ストレート・フラッシュ"
      end
    end
  end
end
