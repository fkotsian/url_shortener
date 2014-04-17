class CreateShortenedUrlTable < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, length: 100
      t.string :short_url, length: 20
      t.integer :user_id

      t.timestamps
    end
  end
end
