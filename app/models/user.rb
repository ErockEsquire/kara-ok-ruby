class User < ApplicationRecord
  has_many :playlists, dependent: :destroy
  has_many :songs, through: :playlist_songs
  validates :username, uniqueness: true
end
