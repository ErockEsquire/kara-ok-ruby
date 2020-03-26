class PlaylistSongsController < ApplicationController

  def index
    @playlist_songs = PlaylistSong.all.uniq(&:song_id)
  end

  def destroy
    @playlist_song = PlaylistSong.find_by(playlist_id: params[:playlist_id], song_id: params[:song_id])
    @playlist_song.destroy
    redirect_to request.referrer
  end

end
