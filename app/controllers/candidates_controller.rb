# frozen_string_literal: true

class CandidatesController < ApplicationController
  def index
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to(chat_path(@candidate), notice: "Candidate was successfully created.")
    else
      render("candidates/index")
    end
  end

  private
    def candidate_params
      params.require(:candidate).permit(:name, :email)
    end
end
