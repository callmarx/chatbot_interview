# frozen_string_literal: true

class CandidatesController < ApplicationController
  def index
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)

    ## NOTE: this is not a correct approach in a formal Rails application. It was used to speed up development.
    if @candidate.save
      redirect_to(chat_path(@candidate))
    else
      flash[:alert] = "There was an error on your apply. Please try again."
      redirect_to(root_path)
    end
  end

  private
    def candidate_params
      params.require(:candidate).permit(:name, :email)
    end
end
