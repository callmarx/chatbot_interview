# frozen_string_literal: true

class ChatController < ApplicationController
  before_action :set_candidate, only: %i[show create]

  def show
    @message = Message.new
  end

  def create
    @chat_history = @candidate.chat_history
    @message = @candidate.messages.build(message_params)

    unless @message.save && handle_bot_answer?
      flash[:alert] = "There was an error processing your message. Please try again."
    end
    ## NOTE: this is not a correct approach in a formal Rails application. It was used to speed up development.
    redirect_to(chat_path(@candidate))
  end

  private
    def set_candidate
      @candidate = Candidate.find(params[:candidate_id])
    end

    def message_params
      params.require(:message).permit(:content).merge(sender: :user)
    end

    def handle_bot_answer?
      body_response = OpenaiService.new(@message.content, @chat_history).perform
      Rails.logger.debug { "### DEBUG - GPT Body Response: #{body_response.inspect}" }

      if body_response["choices"].present?
        bot_answer = body_response["choices"].first["message"]["content"]
        @candidate.messages.create(sender: "assistant", content: bot_answer)
      else
        Rails.logger.error("### ERROR - GPT Body Response: #{body_response.inspect}")
        false
      end
    end
end
