# frozen_string_literal: true

require "rails_helper"

RSpec.describe OpenaiService, type: :service do
  let(:prompt) { "Quais são os benefícios dessa vaga?" }
  let(:service) { described_class.new(prompt) }
  let(:api_url) { ENV.fetch("OPENAI_API_URL") }
  let(:api_key) { ENV.fetch("OPENAI_API_KEY") }
  let(:model) { ENV.fetch("MODEL") }
  let(:temperature) { ENV.fetch("TEMPERATURE").to_i }
  let(:max_tokens) { ENV.fetch("MAX_TOKENS").to_i }
  let(:top_p) { ENV.fetch("TOP_P").to_i }
  let(:context) do
    <<~TEXT
      You are Fernanda, a recruiter responsible for the Plaza developer position.
      You should only return responses of up to 30 words.
      You must respond in brazilian portuguese.

      You should obtain the following information from the candidate:
      - How many years of experience he or she has
      - What is his/her favorite programming language
      - Whether or not he/she is willing to program using ruby
      - Whether or not he/she is willing to work on-site
      - When the applicant would like to interview

      You must answer any questions the potential candidate might have about the job post and you cannot talk about anything other than the job opportunity.

      The job post is:
      #{Rails.root.join("config/job_post_description.txt").read}
    TEXT
  end

  describe "#perform" do
    before do
      allow(HTTParty).to receive(:post).and_return(http_response)
    end

    context "when the API request is successful" do
      let(:http_response) do
        instance_double(
          HTTParty::Response,
          success?: true,
          body: { "choices" => [{ "message" => { "content" => "Expected response" } }] }.to_json
        )
      end

      it "returns the parsed response" do
        result = service.perform
        expect(result).to eq("choices" => [{ "message" => { "content" => "Expected response" } }])
      end

      it "makes a POST request to the OpenAI API with the correct parameters" do
        service.perform

        expect(HTTParty).to have_received(:post).with(
          api_url,
          headers: {
            "Content-Type" => "application/json",
            "Authorization" => "Bearer #{api_key}"
          },
          body: {
            model: model,
            messages: [
              { role: "system", content: context },
              { role: "assistant",
                content: "Olá, me chamo Fernanda e sou a recrutadora responsável pela vaga de desenvolvedor da Plaza. Você tem alguma dúvida sobre a vaga?" },
              { role: "user", content: prompt }
            ],
            temperature: temperature,
            max_tokens: max_tokens,
            top_p: top_p
          }.to_json
        )
      end
    end

    context "when the API request fails", pending: "treat real errors" do
      let(:http_response) do
        instance_double(HTTParty::Response, success?: false, body: { "error" => "Some error" }.to_json)
      end

      it "logs an error" do
        allow(Rails.logger).to receive(:error)

        service.perform

        expect(Rails.logger).to have_received(:error).with("OpenAI API request failed: #{http_response.body}")
      end

      it "returns a failure message" do
        result = service.perform

        expect(result).to eq("error" => "Failed to get response from OpenAI API")
      end
    end
  end
end
