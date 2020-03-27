Rails.application.routes.draw do
  resources :songs
  resources :playlists
  resources :users
  resources :playlist_songs
  
  post "/songs/:playlist_id/add_to_playlist", to: "songs#add_to_playlist", as: "add_to_playlist"
  post "/songs/add_to_songs", to: "songs#add_to_songs", as: "add_to_songs"
  post "/songs/sort_artist", to: "songs#sort_artist", as: "sort_artist"
  post "/songs/sort_title", to: "songs#sort_title", as: "sort_title"
  get "/songs/:id/:playlist_id", to: "songs#show"
  delete "/playlist_songs/:playlist_id/:song_id", to: "playlist_songs#destroy"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end