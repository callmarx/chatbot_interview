# frozen_string_literal: true

require "rails_helper"

RSpec.describe Message, type: :model do
  subject(:msg) { build(:message) }

  let(:candidate) { create(:candidate) }

  describe "validations" do
    it { is_expected.to belong_to(:candidate) }

    it {
      expect(msg).to define_enum_for(:sender)
        .with_values({ assistant: "assistant", user: "user" })
        .backed_by_column_of_type(:enum)
    }
  end

  context "when the message is from the assistant" do
    it 'enqueues the RetrieveUserInfoJob if the content ends with "Tenha uma ótima semana!"' do
      allow(RetrieveUserInfoJob).to receive(:perform_async)

      described_class.create(
        sender: :assistant,
        content: "Aqui está a informação que você pediu. Tenha uma ótima semana!",
        candidate: candidate
      )

      expect(RetrieveUserInfoJob).to have_received(:perform_async).with(candidate.id)
    end

    it 'does not enqueue the RetrieveUserInfoJob if the content does not end with "Tenha uma ótima semana!"' do
      allow(RetrieveUserInfoJob).to receive(:perform_async)

      described_class.create(
        sender: :assistant,
        content: "Aqui está a informação que você pediu.",
        candidate: candidate
      )

      expect(RetrieveUserInfoJob).not_to have_received(:perform_async)
    end
  end

  context "when the message is from the user" do
    it "does not enqueue the RetrieveUserInfoJob" do
      allow(RetrieveUserInfoJob).to receive(:perform_async)

      described_class.create(sender: :user, content: "Tenha uma ótima semana!", candidate: candidate)

      expect(RetrieveUserInfoJob).not_to have_received(:perform_async)
    end
  end
end
