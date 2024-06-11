class CreateCandidates < ActiveRecord::Migration[7.1]
  def change
    create_table :candidates do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :years_of_experience
      t.string :favorite_programming_language
      t.boolean :willing_to_work_onsite
      t.boolean :willing_to_use_ruby
      t.string :interview_date
      t.boolean :completed, default: false

      t.timestamps
    end
    add_index :candidates, :email, unique: true
  end
end
