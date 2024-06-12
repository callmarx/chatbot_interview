# frozen_string_literal: true

class OpenaiService
  API_URL = ENV.fetch("OPENAI_API_URL")
  API_KEY = ENV.fetch("OPENAI_API_KEY")
  MODEL = ENV.fetch("MODEL")
  HEADERS = { "Content-Type" => "application/json", "Authorization" => "Bearer #{API_KEY}" }.freeze

  def initialize(prompt, chat_history)
    @prompt = prompt
    @chat_history = chat_history
    @context = Rails.root.join("config/gpt_context.txt").read
  end

  def perform
    response = send_request
    Rails.logger.debug { "### DEBUG - GPT Body Sent: #{build_request_body.inspect}" }
    handle_response(response)
  end

  private
    def send_request
      HTTParty.post(API_URL, headers: HEADERS, body: build_request_body.to_json)
    end

    def build_request_body
      messages = @chat_history.unshift({ role: "system", content: @context })
      messages.push({ role: "user", content: @prompt })
      {
        model: MODEL,
        messages: messages,
        temperature: ENV.fetch("TEMPERATURE", 1).to_f,
        max_tokens: ENV.fetch("MAX_TOKENS", 300).to_i
      }
    end

    def handle_response(response)
      if response.success?
        JSON.parse(response.body)
      else
        Rails.logger.error("OpenAI API request failed: #{response.body}")
        { "error" => "Failed to get response from OpenAI API" }
      end
    end
end
