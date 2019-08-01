class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create
    @pet.name = params[:pet][:name]

    if !params[:pet][:owner][:name].empty?
      @owner = Owner.create(name: params[:pet][:owner][:name])
      @owner.save
      @pet.owner_id = @owner.id
    else
      @pet.owner_id = params[:pet][:owner][:owner_ids][0]
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])

    if !params[:pet][:name].empty?
      @pet.name = params[:pet][:name]
    end
    
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
      @owner.save
      @pet.owner_id = @owner.id
    else
      @pet.owner_id = params[:pet][:owner_ids][0]
    end
    
     @pet.save

    redirect to "pets/#{@pet.id}"
  end
end