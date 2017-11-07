require 'rails_helper'


RSpec.describe "Apis", type: :request do
  describe "GET /apis" do
    describe "api/cards/check" do
      context "正常系" do
        before do
          host! "localhost:3000"
        end
        example "apiが正常に動くか" do
          get "/api/v1/cards/check"
          expect(response).to have_http_status(200)
        end

        example "期待したJSONを返すか" do
          #get "/api/v1/cards/check", param: { "cards": ["H1 H2 H3 H4 H5", "D1 D2 H2 C1 S1"] }
        end
      end
    end
  end
end
