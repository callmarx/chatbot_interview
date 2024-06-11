# frozen_string_literal: true

class OpenaiService
  def initialize(prompt)
    @prompt = prompt
  end

  def perform
    response = HTTParty.post(
      ENV.fetch("OPENAI_API_URL", nil),
      headers: {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{ENV.fetch("OPENAI_API_KEY", nil)}"
      },
      body: build_request_body
    )
    handle_response(response)
  end

  private
    def build_request_body
      {
        model: ENV.fetch("MODEL", nil),
        messages: [
          { role: "system", content: load_context },
          { role: "assistant",
            content: "Olá, me chamo Fernanda e sou a recrutadora responsável pela vaga de desenvolvedor da Plaza. Você tem alguma dúvida sobre a vaga?" },
          { role: "user", content: @prompt }
        ],
        temperature: ENV.fetch("TEMPERATURE").to_i,
        max_tokens: ENV.fetch("MAX_TOKENS").to_i,
        top_p: ENV.fetch("TOP_P").to_i
      }.to_json
    end

    def handle_response(response)
      if response.success?
        JSON.parse(response.body)
      else
        Rails.logger.error("OpenAI API request failed: #{response.body}")
        { "error" => "Failed to get response from OpenAI API" }
      end
    end

    def load_context
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
end
