# frozen_string_literal: true

require "rails_helper"

RSpec.describe Candidate, type: :model do
  subject { build(:candidate) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value("test@example.com").for(:email) }
    it { is_expected.not_to allow_value("invalid_email").for(:email) }
  end
end
