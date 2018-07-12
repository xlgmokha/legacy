class Organization < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :uuid, index: true
      t.string :name
      t.timestamps
    end
  end
end
