class PetsController < ApplicationController

  # index
  get '/pets' do
    @pets = Pet.all

    erb :'/pets/index' 
  end

  # create
  get '/pets/new' do 
    @owners = Owner.all

    erb :'/pets/new'
  end

  # create
  post '/pets' do 
    @pet = Pet.create(params[:pet])
    @pet.update(owner_id: params[:owner_id]) if params[:owner_id]
    
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end

  # read
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])

    erb :'/pets/show'
  end

  # update
  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])
  
    erb :'/pets/edit'
  end

  # update
  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.owner_id = params[:owner_id] if params[:owner_id]

      if !params[:owner][:name].empty?
        @pet.owner = Owner.create(name: params[:owner][:name])
        @pet.save
      end

    @pet.update(params[:pet])

    redirect to "pets/#{@pet.id}"
  end
  
end