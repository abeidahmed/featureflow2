class CreateCollaborators < ActiveRecord::Migration[6.1]
  def change
    create_table :collaborators do |t|
      t.string :role, default: "editor"
      t.string :token
      t.datetime :joined_at
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :account, null: false, foreign_key: true

      t.timestamps
    end

    add_index :collaborators, %i[account_id user_id], unique: true
    add_index :collaborators, :token, unique: true
    add_index :collaborators, :role
  end
end
