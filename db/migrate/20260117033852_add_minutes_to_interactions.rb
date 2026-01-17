class AddMinutesToInteractions < ActiveRecord::Migration[8.1]
  def change
    add_column :interactions, :minutes, :text
  end
end
