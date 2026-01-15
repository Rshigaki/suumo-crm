class CreateMediaSources < ActiveRecord::Migration[8.1]
  def change
    create_table :media_sources do |t|
      t.string :name
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
