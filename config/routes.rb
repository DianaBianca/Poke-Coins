Rails.application.routes.draw do
  get '/aquisition_pokemon', to: 'pokemon#new_aquisition'
  post "/buy_pokemon", to: "pokemon#create"
end
