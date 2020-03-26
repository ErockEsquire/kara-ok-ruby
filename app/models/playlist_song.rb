class PlaylistSong < ApplicationRecord
  belongs_to :playlist, required: false
  belongs_to :song, required: false
  belongs_to :user, required: false
end
