class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
    end

    create_table :tweets do |t|
      t.text :content
      t.belongs_to :user
    end
  end
end
