require 'rails_helper'


RSpec.describe "Apis", type: :request do
  describe "api/cards/check" do
    context "正常系" do
      before do
        host! "localhost:3000"
        params = { cards: ["H1 H2 H3 H4 H5", "D1 D2 H2 C1 S1"] }
        post '/api/v1/cards/check', params: params
      end
      example "apiが正常に動くか" do
        expect(response).to have_http_status 201
      end

      example "期待したJSONを返すか" do
        parsed_json = ActiveSupport::JSON.decode(response.body)
        p parsed_json

        expect(parsed_json['result'][0]['card']).to eq "H1 H2 H3 H4 H5"
        expect(parsed_json['result'][0]['hand']).to eq "ストレート・フラッシュ"
        expect(parsed_json['result'][0]['best']).to eq true

        expect(parsed_json['result'][1]['card']).to eq "D1 D2 H2 C1 S1"
        expect(parsed_json['result'][1]['hand']).to eq "フルハウス"
        expect(parsed_json['result'][1]['best']).to eq false

      end
    end
    context "異常系" do
      context "パラメータがない" do
        before do
          host! "localhost:3000"
          post '/api/v1/cards/check', params: {}
        end

        example "401が返ってくる" do
          expect(response).to have_http_status 401
        end
      end
      context "関係のないパスを叩く" do

        for path in ["/v1", "/v1/hogehoge", "/v1/cards/hogehoge", "/v1/cards/check/hogehoge"]
          before do
            host! "localhost:3000/api"
            post path
          end

          example "404が返ってくる" do
            expect(response).to have_http_status 404
          end
        end
      end
    end
  end
end
