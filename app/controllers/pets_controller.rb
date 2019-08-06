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
    @pet = Pet.create(name: params[:pet_name])
    @pet.update(owner_id: params[:owner_id]) if params[:owner_id]

    if !params[:owner_name].empty?
      @pet.owner = Owner.create(name: params[:owner_name])
      @pet.save
    end
    redirect "pets/#{@pet.id}"
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
    @pet.name = params[:pet_name]
    @pet.owner_id = params[:owner_id] if params[:owner_id]

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save

    redirect "pets/#{@pet.id}"
  end

end
