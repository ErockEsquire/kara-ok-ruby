class AddVideoToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :video_url, :string
  end
end
