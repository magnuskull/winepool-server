require 'rspec_api_documentation_helper'

RSpec.resource "Shares" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "share parameters" do

    parameter "type", <<-DESC, required: true
      The type of resource. Must be 'shares'.
    DESC

    let "type" do
      "shares"
    end

    parameter "amount", <<-DESC, scope: :attributes, required: true
      The amount of bottles in the share.
    DESC

    let "amount" do
      3
    end

    parameter "wine", <<-DESC, scope: :relationships, required: true
      The wine to share.
    DESC

    parameter "user", <<-DESC, scope: :relationships, required: true
      The user that owns the share.
    DESC

  end

  shared_context "with a persisted share" do
    let! :persisted_share do
      FactoryGirl.create(:share)
    end

    let "share_id" do
      persisted_share.id.to_s
    end
  end

  post "/v1/shares" do
    include_context "share parameters"

    let! :persisted_wine do
      FactoryGirl.create(:wine)
    end

    let "wine" do
      {
        data: {
          type: "wines",
          id: persisted_wine.id.to_s
        }
      }
    end

    let! :persisted_user do
      FactoryGirl.create(:user)
    end

    let "user" do
      {
        data: {
          type: "users",
          id: persisted_user.id.to_s
        }
      }
    end

    example_request "POST /v1/shares" do
      expect(status).to eq 201
      share = JSON.parse(response_body)
      expect(share["data"]["attributes"]["amount"]).to eq 3
    end
  end

  patch "/v1/shares/:share_id" do
    include_context "with a persisted share"

    parameter "id", <<-DESC, required: true
      The id of the share.
    DESC

    let :id do
      persisted_share.id.to_s
    end

    include_context "share parameters"

    let "amount" do
      2
    end

    example_request "PATCH /v1/shares/:id" do
      expect(status).to eq 200
      share = JSON.parse(response_body)
      expect(share["data"]["attributes"]["amount"]).to eq public_send("amount")
    end

  end

  get "/v1/shares/:share_id" do
    include_context "with a persisted share"

    example_request "GET /v1/shares/:id" do
      expect(status).to eq 200
    end

  end

  get "/v1/shares" do
    before do
      2.times do
        FactoryGirl.create(:share)
      end
    end
    example_request "GET /v1/shares" do
      expect(status).to eq 200
      shares = JSON.parse(response_body)
      expect(shares["data"].length).to eq 2
    end
  end

  delete "/v1/shares/:share_id" do
    include_context "with a persisted share"

    let :id do
      persisted_share.id.to_s
    end

    example_request "DELETE /v1/shares/:id" do
      expect(status).to eq 204
    end
  end

end
