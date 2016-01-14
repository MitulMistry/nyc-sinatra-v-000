class LandmarksController < ApplicationController

  #allows you to view form to create a new landmark
  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  post '/landmarks' do
    @landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    redirect to "/landmarks/#{@landmark.id}"
  end

  #allows you to list all landmarks
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  #allows you to see a single landmark
  get '/landmarks/:landmark_id' do
    @landmark = Landmark.find_by_id(params[:landmark_id])
    erb :'landmarks/show'
  end

  #allows you to view form edit a single landmark
  get '/landmarks/:landmark_id/edit' do
    @landmark = Landmark.find_by_id(params[:landmark_id])
    erb :'landmarks/edit'
  end

  post '/landmarks/:landmark_id' do
    @landmark = Landmark.find_by_id(params[:landmark_id])
    @landmark.name = params[:landmark][:name]
    @landmark.year_completed = params[:landmark][:year_completed]
    @landmark.save
    erb :'landmarks/show'
  end
end