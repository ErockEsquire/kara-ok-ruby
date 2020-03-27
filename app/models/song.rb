class Song < ApplicationRecord
  has_many :playlist_songs, dependent: :destroy
  has_many :users, through: :playlists
  validates :title, uniqueness: true
end