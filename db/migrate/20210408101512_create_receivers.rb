class CreateReceivers < ActiveRecord::Migration[6.0]
  def change
    create_table :receivers do |t|
      t.string :name
      t.integer :capacity
      t.references :poll, null: false, foreign_key: true

      t.timestamps
    end
  end
end
