require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( '../models/owner' )
require_relative( '../models/pet' )
also_reload( '../models/*' )

#index
get '/owners' do
  @owner = Owner.all()
  erb (:"owners/index")
end

#new
get '/owners/new' do
  @owner = Owner.all()
  erb (:"owners/new")
end

#create
post '/owners' do
  @owner = Owner.new(params)
  @owner.save
  erb (:"owners/create")
end

#edit
get '/owners/:id/edit' do
  @owner = Owner.find( params[:id] )
  erb (:"owners/edit")
end

#update
post '/owners/:id' do
  Owner.new( params ).update
  redirect to '/owners'
end


#delete
post '/owners/:id/delete' do
  owner = Owner.find(params[:id])
  owner.delete
  redirect to '/owners'
end

#show
get '/owners/:id' do
  @owner = Owner.find( params[:id] )
  erb( :"owners/show" )
end
