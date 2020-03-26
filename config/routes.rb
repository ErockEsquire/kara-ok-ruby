Rails.application.routes.draw do
  resources :songs
  resources :playlists
  resources :users
  resources :playlist_songs
  
  post "/songs/:playlist_id/add_to_playlist", to: "songs#add_to_playlist", as: "add_to_playlist"
  post "/songs/add_to_songs", to: "songs#add_to_songs", as: "add_to_songs"
  delete "/playlist_songs/:playlist_id/:song_id", to: "playlist_songs#destroy"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end