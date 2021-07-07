class CreateStages < ActiveRecord::Migration[6.1]
  def change
    create_table :stages do |t|
      t.string :name
      t.string :color
      t.integer :position
      t.belongs_to :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
