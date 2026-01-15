class CreatePointLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :point_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :points
      t.string :reason
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
