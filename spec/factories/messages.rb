# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    sender { "user" }
    content { "Olá, quais os próximos passos agora?" }
    association :candidate
  end
end
