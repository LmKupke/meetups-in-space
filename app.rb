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
  current_user
  id = params['id']
  @meetup = Meetup.find(id)
  @attendees = Usermeetup.where(meetup: id)
  erb :'meetups/show'
end

post '/meetups' do
  current_user
  @error = nil
  @name = params[:name]
  @location = params[:location]
  @description = params[:description]

  if @current_user == nil
    @error = "You will need to sign in before you can create a Meetup!"
    erb :'/meetups/new'
  elsif @name.empty? || @location.empty? || @description.empty?
    @error = 'Please fill in all form fields'
    erb :'meetups/new'
  else
    @meetup = Meetup.create(name: @name, location: @location, description: @description, user: @current_user)
    Usermeetup.create(meetup: @meetup, user: @meetup.user)
    @attendees = Usermeetup.where(meetup: @meetup)
    redirect "/meetups/#{@meetup.id}"
  end
end

post '/meetups/:id/join' do
  current_user
  id = params[:id]

  if @current_user.nil?
    flash[:notice] = "Please sign in before joining meetups"
  else
    @meetup = Meetup.find(id)
    Usermeetup.create(user: @current_user, meetup: @meetup)
    flash[:notice] = "You have joined the meetup."
  end

  redirect "/meetups/#{id}"
end
