class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
    if !params[:playlist_id].blank?
      @playlist = Playlist.find(params[:playlist_id])
    end
  end

  def new
    @song = Song.new
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    @song.update(song_params)
    redirect_to @song
  end

  def add_to_playlist
    artist = params[:artist].titleize
    title = params[:title].titleize
    begin
      result = RestClient.get("https://api.lyrics.ovh/v1/#{artist.gsub(/\s/, "+")}/#{title.gsub(/\s/, "+")}")
    rescue RestClient::NotFound => e
      flash[:alert] = " ¯\\(◉_◉)/¯ Song was not found. Please try a different spelling, or a different song!"
      redirect_to playlist_path(params[:playlist_id])
    else
      resp_hash = JSON.parse(result.body)
      lyrics = resp_hash["lyrics"]
      if !Song.find_by(title: title, artist: artist)
        @song = Song.create(title: title, artist: artist, lyrics: lyrics)
        @playlist_song = PlaylistSong.create(playlist_id: params[:playlist_id], song_id: @song.id)
        flash[:notice] = "(>ﾟヮﾟ)> Song has been added! <(ﾟヮﾟ<)"
        redirect_to request.referrer
      else
        @song = Song.find_by(title: title, artist: artist)
        if !PlaylistSong.find_by(playlist_id: params[:playlist_id], song_id: @song.id)
          @playlist_song = PlaylistSong.create(playlist_id: params[:playlist_id], song_id: @song.id)
          flash[:notice] = "(>ﾟヮﾟ)> Song has been added! <(ﾟヮﾟ<)"
          redirect_to request.referrer
        else
          flash[:alert] = "(；￣ .￣）...this song is already in playlist!"
          redirect_to request.referrer
        end
      end
    end
  end

  def add_to_songs
    artist = params[:artist].titleize
    title = params[:title].titleize
    begin
      result = RestClient.get("https://api.lyrics.ovh/v1/#{artist.gsub(/\s/, "+")}/#{title.gsub(/\s/, "+")}")
    rescue RestClient::NotFound => e
      flash[:alert] = " ¯\\(◉_◉)/¯ Song was not found. Please try a different spelling, or a different song!"
      redirect_to songs_path
    else
      resp_hash = JSON.parse(result.body)
      lyrics = resp_hash["lyrics"]
      if !Song.find_by(title: title, artist: artist)
        @song = Song.create(title: title, artist: artist, lyrics: lyrics)
        flash[:notice] = "(>ﾟヮﾟ)> Song has been added! <( ﾟヮﾟ<)"
        redirect_to request.referrer
      else
        flash[:alert] = "(；￣ .￣）...this song is already in the vault"
        redirect_to request.referrer
      end
    end
  end

  def sort_artist
    @songs = Song.all.sort_by(&:artist)
    render :index
  end

  def sort_title
    @songs = Song.all.sort_by(&:title)
    render :index
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to songs_path
  end

  private
  def song_params
    params.require(:song).permit(:title, :artist, :lyrics, :video_url)
  end

end
