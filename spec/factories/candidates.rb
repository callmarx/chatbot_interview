# frozen_string_literal: true

FactoryBot.define do
  factory :candidate do
    name { "MyString" }
    email { "MyString" }
    years_of_experience { 1 }
    favorite_programming_language { "MyString" }
    willing_to_work_onsite { false }
    willing_to_use_ruby { false }
    interview_date { "MyString" }
    completed { false }
  end
end
