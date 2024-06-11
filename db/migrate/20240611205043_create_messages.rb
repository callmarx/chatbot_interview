class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_enum :senders, ["assistant", "user"]

    create_table :messages do |t|
      t.enum :sender, enum_type: "senders", null: false
      t.text :content, null: false
      t.references :candidate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
