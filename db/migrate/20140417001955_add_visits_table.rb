class AddVisitsTable < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :user_id
      t.integer :shortened_url_id
    end
  end
end
