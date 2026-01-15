class CreateInteractions < ActiveRecord::Migration[8.1]
  def change
    create_table :interactions do |t|
      t.references :customer, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :ended_at
      t.string :recording_url
      t.text :transcript
      t.text :memo
      t.jsonb :questionnaire_data
      t.integer :status

      t.timestamps
    end
  end
end
