# frozen_string_literal: true

class Candidate < ApplicationRecord
  has_many :messages, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  after_create :create_initial_message

  def chat_history
    messages.map { |msg| { role: msg.sender, content: msg.content } }
  end

  private
    def create_initial_message
      messages.create(
        sender: :assistant,
        # rubocop:disable Layout/LineLength
        content: "Olá, me chamo Fernanda e sou a recrutadora responsável pela vaga de desenvolvedor da Plaza. Você tem alguma dúvida sobre a vaga?"
        # rubocop:enable Layout/LineLength
      )
    end
end
