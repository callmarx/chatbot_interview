# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Candidates", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    pending "add some examples (or delete) #{__FILE__}"
  end
end
