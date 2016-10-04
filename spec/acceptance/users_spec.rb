require 'rspec_api_documentation_helper'

RSpec.resource "Users" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "user parameters" do
    parameter "type", <<-DESC, required: true
      The type of the resource. Must be 'users'.
    DESC
    let "type" do
      "users"
    end
    parameter "name", <<-DESC, scope: :attributes, required: true
      The name of the user.
    DESC
    parameter "mobile-phone-number", <<-DESC, scope: :attributes
      The mobile phone number of the user.
    DESC
    parameter "email-address", <<-DESC, scope: :attributes, required: true
      The email address of the user.
    DESC
  end

  shared_context "with a persisted user" do
    let! :persisted_user do
      FactoryGirl.create(:user)
    end
    let "user_id" do
      persisted_user.id.to_s
    end
  end

  post "/v1/users" do
    include_context "user parameters"

    let "name" do
      "Magnus Kull"
    end
    let "mobile-phone-number" do
      "123456789"
    end
    let "email-address" do
      "magnus.kull@gmail.com"
    end
    example_request "POST /v1/users" do
      expect(status).to eq 201
      user = JSON.parse(response_body)
      expect(user["data"]["attributes"]["email-address"]).to eq "magnus.kull@gmail.com"
    end
  end

  get "/v1/users/:user_id" do
    include_context "with a persisted user"

    example_request "GET /v1/users/:id" do
      expect(status).to eq 200
    end
  end

  patch "/v1/users/:user_id" do
    include_context "with a persisted user"

    parameter "id", <<-DESC, required: true
      The id of the user.
    DESC

    let :id do
      persisted_user.id.to_s
    end

    include_context "user parameters"

    let "name" do
      "New First Name"
    end

    example_request "PATCH /v1/users/:id" do
      expect(status).to eq 200
      user = JSON.parse(response_body)
      expect(user["data"]["attributes"]["name"]).to eq public_send("name")
    end
  end

  get "/v1/users" do
    before do
      2.times do
        FactoryGirl.create(:user)
      end
    end

    example_request "GET /v1/users" do
      expect(status).to eq 200
      users = JSON.parse(response_body)
      expect(users["data"].length).to eq 2
    end
  end

  delete "/v1/users/:user_id" do
    include_context "with a persisted user"

    example "DELETE /v1/users/", document: false do
      expect{do_request}.to raise_error(ActionController::RoutingError)
    end
  end
end
