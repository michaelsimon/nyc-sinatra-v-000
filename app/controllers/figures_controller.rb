class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end
  
  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :"figures/new"
  end
  
  post '/figures/new' do
    # binding.pry
    @figure = Figure.create(params["figure"])
    if !params["landmark"]["name"].empty?
      @landmark = Landmark.create(name: params["landmark"]["name"])
      @figure.landmarks << @landmark
    end
    if !params["title"]["name"].empty?
      @title = Title.create(name: params["title"]["name"])
      @figure.titles << @title
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :"figures/edit"
  end

    post '/figures/:id/edit' do
    # binding.pry
    @figure = Figure.find(params[:id])
    @figure.update(params["figure"])
    if !params["landmark"]["name"].empty? 
      @landmark = Landmark.create(name: params["landmark"]["name"]) if !Landmark.find_by(name: params["landmark"]["name"])
      @landmark = Landmark.find_by(name: params["landmark"]["name"]) if Landmark.find_by(name: params["landmark"]["name"])
      @figure.landmarks << @landmark
    end
    if !params["title"]["name"].empty?
      @title = Title.create(name: params["title"]["name"]) if !Title.find_by(name: params["title"]["name"])
      @title = Title.find_by(name: params["title"]["name"]) if Title.find_by(name: params["title"]["name"])
      @figure.titles << @title
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

end