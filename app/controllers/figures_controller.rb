class FiguresController < ApplicationController

  #allows you to view form to create a new figure
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures/new' do
    @figure = Figure.new(name: params[:figure][:name]) # new rather than create so doesn't have to write to database twice (has to save at the end)
    @figure.title_ids = params[:figure][:title_ids] # set title ids to array of ids from checkboxes
    @figure.landmark_ids = params[:figure][:landmark_ids]

    if !params[:title][:name].empty?
      @title = Title.create(name: params[:title][:name])
      @figure.titles << @title
    end

    if !params[:landmark][:name].empty?
      @landmark = Landmark.create(name: params[:landmark][:name])
      @figure.landmarks << @landmark
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  #allows you to list all figures
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  #allows you to see a single Figure
  get '/figures/:figure_id' do
    @figure = Figure.find_by_id(params[:figure_id])
    erb :'figures/show'
  end

  #allows you to view form to edit a single figure
  get '/figures/:figure_id/edit' do
    @figure = Figure.find_by_id(params[:figure_id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  post '/figures/:figure_id' do
    @figure = Figure.find_by_id(params[:figure_id])
    @figure.name = params[:figure][:name]
    @figure.title_ids = params[:figure][:title_ids] # set title ids to array of ids from checkboxes
    @figure.landmark_ids = params[:figure][:landmark_ids]

    if !params[:title][:name].empty?
      @title = Title.create(name: params[:title][:name])
      @figure.titles << @title
    end

    if !params[:landmark][:name].empty?
      @landmark = Landmark.create(name: params[:landmark][:name])
      @figure.landmarks << @landmark
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
end