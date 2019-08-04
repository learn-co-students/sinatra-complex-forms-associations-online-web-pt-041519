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
    if !params[:owner_id].nil?
      Owner.find(params[:owner_id]).pets << @pet
    else
      Owner.create(params[:owner]).pets << @pet if !params[:owner].empty?
    end
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
    @pet.update(name: params[:pet_name])
    Owner.find(params[:owner_id]).pets << @pet if !params[:owner_id].nil?
    Owner.create(params[:owner]).pets << @pet if !params[:owner][:name].empty?
    redirect to "pets/#{@pet.id}"
  end
end
