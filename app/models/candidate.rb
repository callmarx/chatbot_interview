# frozen_string_literal: true

class Candidate < ApplicationRecord
  has_many :messages, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
