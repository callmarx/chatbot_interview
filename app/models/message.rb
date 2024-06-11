# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :candidate
  enum :sender, { assistant: "assistant", user: "user" }, validate: true
end
