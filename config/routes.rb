Rails.application.routes.draw do
  get '/aquisition_pokemon', to: 'pokemon#new_aquisition'
  get "buy_pokemon", to: "pokemon#create"
end
