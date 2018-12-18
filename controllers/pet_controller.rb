require( 'sinatra' )
  require( 'sinatra/contrib/all' )
  require( 'pry-byebug' )

  require_relative( '../models/owner' )
  require_relative( '../models/pet' )
  also_reload( '../models/*' )

  #index
  get '/pets' do
    @pet = Pet.all()
    erb (:"pets/index")
  end

  # #new
  get '/pets/new' do
    @owners = Owner.all()
    erb (:"pets/new")
  end

  #create
  post '/pets' do
    @pet = Pet.new(params)
    @pet.save
    erb (:"pets/create")
  end

  #edit
  get '/pets/:id/edit' do
    @pet = Pet.find( params[:id] )
    erb (:"pets/edit")
  end

  #update
  post '/pets/:id' do
    Pet.new( params ).update
    redirect to '/pets'
  end


  #delete
  post '/pets/:id/delete' do
    pet = Pet.find(params[:id])
    pet.delete
    redirect to '/pets'
  end

  #show
  get '/pets/:id' do
    @pet = Pet.find( params[:id] )
    erb( :"pets/show" )
  end
