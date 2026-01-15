class AddMediaSourceToCustomers < ActiveRecord::Migration[8.1]
  def change
    add_reference :customers, :media_source, null: false, foreign_key: true
  end
end
