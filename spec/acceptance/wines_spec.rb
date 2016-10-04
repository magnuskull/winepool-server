require 'rspec_api_documentation_helper'

RSpec.resource "Wines" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "wine parameters" do
    parameter "type", <<-DESC, required: true
      The type of the resource. Must be 'wines'.
    DESC

    let "type" do
      "wines"
    end

    parameter "name", <<-DESC, scope: :attributes, required: true
      The name of the wine.
    DESC

    let "name" do
      "Barolo"
    end

    parameter "description", <<-DESC, scope: :attributes
      The description of the wine.
    DESC

    let "description" do
      "Medium+ acidity. Needs time."
    end

    parameter "bottles", <<-DESC, scope: :attributes, required: true
      The number of bottles required for an order.
    DESC

    let "bottles" do
      6
    end

    parameter "price", <<-DESC, scope: :attributes, required: true
      The price of the wine per bottle.
    DESC

    let "price" do
      179
    end

    parameter "suggester", <<-DESC, required:true, scope: :relationships
      The user that suggests to buy the wine.
    DESC

  end

  shared_context "with a persisted wine" do
    let! :persisted_wine do
      FactoryGirl.create(:wine)
    end

    let "wine_id" do
      persisted_wine.id.to_s
    end
  end

  post "/v1/wines" do
    let! :persisted_user do
      FactoryGirl.create(:user)
    end

    let "suggester" do
      {
        data: {
          type: "users",
          id: persisted_user.id.to_s
        }
      }
    end

    include_context "wine parameters"

    example_request "POST /v1/wines" do
      expect(status).to eq 201
      wine = JSON.parse(response_body)
      expect(wine["data"]["attributes"]["name"]).to eq "Barolo"
    end
  end

  patch "/v1/wines/:wine_id" do
    include_context "with a persisted wine"

    parameter "id", <<-DESC, required: true
      The id of the wine.
    DESC

    let :id do
      persisted_wine.id.to_s
    end

    include_context "wine parameters"

    let "name" do
      "Barbaresco"
    end

    example_request "PATCH /v1/wines/:id" do
      expect(status).to eq 200
      wine = JSON.parse(response_body)
      expect(wine["data"]["attributes"]["name"]).to eq public_send("name")
    end
  end

  get "/v1/wines/:id" do
    include_context "with a persisted wine"

    let :id do
      persisted_wine.id.to_s
    end

    example_request "GET /v1/wines/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/wines" do
    before do
      2.times do
        FactoryGirl.create(:wine)
      end
    end

    example_request "GET /v1/wines" do
      expect(status).to eq 200
      wines = JSON.parse(response_body)
      expect(wines["data"].length).to eq 2
    end
  end

  delete "/v1/wines/:id" do
    include_context "with a persisted wine"

    let :id do
      persisted_wine.id.to_s
    end

    example_request "DELETE /v1/wines/:id" do
      expect(status).to eq 204
    end
  end
end
