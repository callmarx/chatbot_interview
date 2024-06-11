# frozen_string_literal: true

require "rails_helper"

RSpec.describe Message, type: :model do
  subject { build(:message) }

  describe "validations" do
    it { is_expected.to belong_to(:candidate) }
    it { is_expected.to define_enum_for(:sender).
      with_values({ assistant: "assistant", user: "user" }).
      backed_by_column_of_type(:enum)
    }
  end
end
