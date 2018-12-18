require('sinatra')
require('sinatra/contrib/all')
 require_relative('controllers/owner_controller.rb')
require_relative('controllers/pet_controller.rb')

get '/' do
 erb(:index)
end
