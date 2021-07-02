class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :subdomain
      t.string :cname
      t.integer :creator_id
      t.string :status, default: "active"

      t.timestamps
    end

    add_index :accounts, :subdomain, unique: true
    add_index :accounts, :cname
    add_index :accounts, :creator_id
    add_index :accounts, :status
  end
end
