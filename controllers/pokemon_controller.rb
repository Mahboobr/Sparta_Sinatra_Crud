class PokemonController < Sinatra::Base
  #sets root of the parent directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')
  #sets the view directory correctly
  set :view, Proc.new { File.join(root,"views")}

  #Enable reloader
  configure :development do
    register Sinatra::Reloader
  end

  $pokemon = [{
        id: 0,
        title: "Rayquaza",
        body: "It flies forever through the ozone layer, consuming meteoroids for sustenance. The many meteoroids in its body provide the energy it needs to Mega Evolve."
    },
    {
        id: 1,
        title: "Mewtwo",
        body: "	Mewtwo is a Pokémon that was created by genetic manipulation. However, even though the scientific power of humans created this Pokémon's body, they failed to endow Mewtwo with a compassionate heart."
    },
    {
        id: 2,
        title: "Arceus",
        body: "It is told in mythology that this Pokémon was born before the universe even existed."
    }
  ];

    get '/' do

      @title = "Pokemon Team"

      @pokemon = $pokemon

      erb :'pokemon/index'

    end

    post '/' do

      new_pokemon = {
        title: params[:title],
        body: params[:body]
      }

      $pokemon.push(new_pokemon)

      redirect "/"

    end

    get '/new'  do
      @pokemon = {
        id: '',
        title: '',
        body: ''
      }

      erb :'pokemon/new'
      # erb needs a space after and posts/new is a symbol so needs a :

    end

    get '/:id' do

      # get the ID and turn it in to an integer
      id = params[:id].to_i

      # make a single post object available in the template
      @pokemon = $pokemon[id]

      erb :'pokemon/show'

    end

    put '/:id'  do

      id = params[:id].to_i
      pokemon = $pokemon[id]
      pokemon[:title] = params[:title]
      pokemon[:body] = params[:body]
      $pokemon[id] = pokemon
      redirect '/'

    end

    delete '/:id'  do

      id = params[:id].to_i

      $pokemon.delete_at(id)
      redirect "/"

    end

    get '/:id/edit'  do

      id = params[:id].to_i

      @pokemon = $pokemon[id]

      erb :'pokemon/edit'

    end

end
