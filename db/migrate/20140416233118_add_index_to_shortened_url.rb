class AddIndexToShortenedUrl < ActiveRecord::Migration
  def change

    add_index(:shortened_urls, :user_id, :unique => true)
    add_index(:shortened_urls, :short_url)

  end
end
