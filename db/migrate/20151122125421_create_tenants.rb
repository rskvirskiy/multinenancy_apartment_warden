class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :tenants, :email, unique: true
    add_index :tenants, :name, unique: true
  end
end
