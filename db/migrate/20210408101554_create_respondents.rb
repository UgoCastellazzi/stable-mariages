class CreateRespondents < ActiveRecord::Migration[6.0]
  def change
    create_table :respondents do |t|
      t.string :name
      t.references :poll, null: false, foreign_key: true
      t.text :wishes, array: true, default: []

      t.timestamps
    end
  end
end
