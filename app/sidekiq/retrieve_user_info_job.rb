# frozen_string_literal: true

class RetrieveUserInfoJob
  include Sidekiq::Job

  def perform(candidate_id)
    candidate = Candidate.find(candidate_id)

    ## NOTE: this is not a correct approach in a formal Rails application. It was used to speed up development.
    body_response = OpenaiService.new(build_question, candidate.chat_history).perform

    bot_answer = body_response["choices"].first["message"]["content"]
    candidate.years_of_experience = bot_answer[/years_of_experience:\s*(.*?)(,|$)/, 1]
    candidate.favorite_programming_language = bot_answer[/favorite_programming_language:\s*(.*?)(,|$)/, 1]
    candidate.willing_to_work_onsite = bot_answer[/willing_to_work_onsite:\s*(.*?)(,|$)/, 1]
    candidate.willing_to_use_ruby = bot_answer[/willing_to_use_ruby:\s*(.*?)(,|$)/, 1]
    candidate.interview_date = bot_answer[/interview_date:\s*(.*?)(,|$)/, 1]
    candidate.completed = true
    candidate.save
  rescue StandardError => e
    Rails.logger.error("Unexpected error in RetrieveUserInfoJob: #{e.message}")
  end

  private
    def build_question
      <<~TEXT
        me responda somente com os valores das variaveis a seguir considerando seus tipos:
        years_of_experience: integer
        favorite_programming_language: string
        willing_to_work_onsite: boolean
        willing_to_use_ruby: boolean
        interview_date: string
      TEXT
    end
end
