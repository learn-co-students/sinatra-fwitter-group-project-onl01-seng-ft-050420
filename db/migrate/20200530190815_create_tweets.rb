class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.belongs_to :user
      t.datetime :posted_at
    end
  end
end
