class Song < ApplicationRecord
  has_many :playlist_songs
  has_many :users, through: :playlists
  validates :title, uniqueness: true
end