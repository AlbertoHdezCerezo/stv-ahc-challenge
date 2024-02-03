class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.text :description
      t.string :image_url
      t.integer :episode_number
      t.integer :season_number

      t.timestamps
    end
  end
end
