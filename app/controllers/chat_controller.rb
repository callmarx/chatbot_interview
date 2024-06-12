# frozen_string_literal: true

class ChatController < ApplicationController
  before_action :set_candidate, only: %i[show create]

  def show
    @message = Message.new
  end

  def create
    @chat_history = @candidate.chat_history
    @message = @candidate.messages.build(message_params)

    if @message.save
      handle_bot_response
    else
      render(:show)
    end
  end

  private
    def set_candidate
      @candidate = Candidate.find(params[:candidate_id])
    end

    def message_params
      params.require(:message).permit(:content).merge(sender: :user)
    end

    def handle_bot_response
      body_response = OpenaiService.new(@message.content, @chat_history).perform
      Rails.logger.debug { "### DEBUG - GPT Body Response: #{body_response.inspect}" }

      if body_response["choices"].present?
        bot_response = body_response["choices"].first["message"]["content"]
        @candidate.messages.create(sender: "assistant", content: bot_response)
        redirect_to(chat_path(@candidate))
      else
        log_error_and_render_show(body_response)
      end
    end

    def log_error_and_render_show(body_response)
      Rails.logger.error("### ERROR - GPT Response: #{body_response.inspect}")
      flash.now[:alert] = "There was an error processing your message. Please try again."
      render(:show)
    end
end
