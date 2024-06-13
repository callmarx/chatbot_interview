# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :candidate
  enum :sender, { assistant: "assistant", user: "user" }, validate: true

  after_create :check_end_conversation

  private
    def check_end_conversation
      return if user?

      return unless /Tenha uma ótima semana!$/.match?(content)

      RetrieveUserInfoJob.perform_async(candidate_id)
    end
end
