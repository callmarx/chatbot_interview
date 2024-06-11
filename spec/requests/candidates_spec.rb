# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Candidates", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /candidates" do
    context "with valid attributes" do
      it "creates a new candidate" do
        post candidates_path, params: { candidate: attributes_for(:candidate) }
        expect(Candidate.count).to be(1)
      end

      it "redirects to root_path" do
        post candidates_path, params: { candidate: attributes_for(:candidate) }
        expect(response).to redirect_to(root_path)
      end

      it "sets a notice message" do
        post candidates_path, params: { candidate: attributes_for(:candidate) }
        expect(flash[:notice]).to eq("Candidate was successfully created.")
      end
    end

    context "with invalid attributes" do
      it "does not create a new candidate" do
        post candidates_path, params: { candidate: attributes_for(:candidate, name: nil) }
        expect(Candidate.count).to be(0)
      end
    end
  end
end
