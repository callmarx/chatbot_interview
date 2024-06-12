# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Candidates", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /candidates' do
    context 'with valid candidate parameters' do
      let(:valid_candidate_params) { { candidate: { name: 'John Doe', email: 'john.doe@example.com' } } }

      it 'creates a new candidate and redirects to chat path' do
        post candidates_path, params: valid_candidate_params
        candidate = Candidate.last

        expect(response).to redirect_to(chat_path(candidate))
        expect(flash[:alert]).to be_nil
      end
    end

    context 'with invalid candidate parameters' do
      let(:invalid_candidate_params) { { candidate: { name: '', email: 'invalid-email' } } }

      it 'does not create a new candidate and redirects to root path with alert' do
        post candidates_path, params: invalid_candidate_params

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("There was an error on your apply. Please try again.")
      end
    end
  end
end
