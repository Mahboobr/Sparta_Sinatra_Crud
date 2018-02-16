require "sinatra"
require "sinatra/reloader" if development?
require_relative "./controllers/pokemon_controller.rb"
# require_relative "./controllers/trainers_controller.rb"

use Rack::MethodOverride


# run Rack::Cascade.new([
#   PokemonController,
#   TrainersController
# ])

run PokemonController
# run TrainersController
