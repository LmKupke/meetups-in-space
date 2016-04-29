require 'sinatra'
require_relative 'config/application'

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.order(:name)

  erb :'meetups/index'
end

get '/meetups/new' do
  erb :'meetups/new'
end

get '/meetups/:id' do
  id = params['id']
  @meetup = Meetup.find(id)
  erb :'meetups/show'
end

post '/meetups' do
  current_user
  @error = nil
  @name = params[:name]
  @location = params[:location]
  @description = params[:description]

  # binding.pry

  if @current_user == nil
    @error = "You will need to sign in before you can create a Meetup!"
    erb :'/meetups/new'
  else
    @meetup = Meetup.create(name: @name, location: @location, description: @description, user: @current_user)
    
    erb :"meetups/show"
  end
end
