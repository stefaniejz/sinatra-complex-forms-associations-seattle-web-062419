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
    if !params["owner"]["name"].empty?
      # case: create new owner
      @pet = Pet.create(name: params["pet_name"])
      @owner = Owner.create(name:params["owner"]["name"])
      @owner.pets<<@pet
    else
      @pet = Pet.create(name: params["pet_name"])
      @owner = Owner.find(params["pet"]["owner_id"])
      @owner.pets<<@pet

    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    #case create new owner
    if !params["owner"]["name"].empty?
      @pet=Pet.find(params[:id])
      @owner= Owner.create(name:params["owner"]["name"])
      @pet.owner=@owner
      @pet.save
  
    else
      @pet=Pet.find(params[:id])
      @pet.update(name:params["pet_name"],owner_id:params["owner"]["id"])
      
      
    end
    redirect to "pets/#{@pet.id}"
  end
end