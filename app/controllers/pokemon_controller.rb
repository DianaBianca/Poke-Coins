class PokemonController < ApplicationController
  def new_aquisition
    @pokemons_data = fetch_pokemons_info
  end
  
  def create
    
    binding.pry
    
    puts "params : #{params}" 
  end

  def sell_pokemon

  end

  private

  def fetch_pokemons_info
    #pega as infos: name, type, experience_quotation da API e retorna em um array de hash fprmatado
    response = Faraday.get("https://pokeapi.co/api/v2/pokemon")
    data = JSON.parse(response.body)["results"]
    poke_names = data.map{|pokemon| pokemon["name"]}

    pokemon_data(poke_names)
  end

  def  pokemon_data(poke_names)
    values = poke_names.map do |name|
      
      data = fetch_pokemon_data(name)

      photo = data["sprites"]["other"]["dream_world"]["front_default"]
      type = data["types"].map{|info| info["type"]["name"]}
      experience = data["base_experience"]
      { name: name, photo: photo, type: type, base_experience: experience, price: experience_quotation(data["base_experience"]).ceil(2) }
    end
  end

  def btc_quotation
    response = Faraday.get("https://www.mercadobitcoin.net/api/BTC/ticker/")
    JSON.parse(response.body)["ticker"]["last"].to_f
  end  

  def experience_quotation(experience)
    btc_quotas = experience * 0.00000001
    final_price = btc_quotas * btc_quotation
  end

  def fetch_pokemon_data(name)
    response = Faraday.get("https://pokeapi.co/api/v2/pokemon/#{name}")
    JSON.parse(response.body)
  end

end
