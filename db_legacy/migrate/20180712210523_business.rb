class Business < ActiveRecord::Migration[4.2]
  def change
    create_table :businesses do |t|
      t.string :uuid, index: true
      t.string :name
      t.timestamps
    end
  end
end
