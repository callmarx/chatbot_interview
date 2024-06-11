# frozen_string_literal: true

class ChatController < ApplicationController
  def show
    @candidate = Candidate.find(params[:candidate_id])
    @message = Message.new
  end

  def create
    @candidate = Candidate.find(params[:candidate_id])
    @message = @candidate.messages.build(message_params)

    if @message.save
      body_response = OpenaiService.new(@message.content).perform
      ## TODO: Improve that!!!
      bot_response = body_response["choices"].first["message"]["content"]
      @candidate.messages.create(sender: "assistant", content: bot_response)

      redirect_to(chat_path(@candidate))
    else
      render(:show)
    end
  end

  private
    def message_params
      params.require(:message).permit(:content).merge(sender: :user)
    end
end
