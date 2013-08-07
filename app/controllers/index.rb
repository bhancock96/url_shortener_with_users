get '/' do
  # Look in app/views/index.erb
  erb :index
end

get "/create" do 

  erb :create_user
end 

get "/secret_page" do
  if current_user 
    erb :secret
  else
    @error = "you gotta login, ya chancho."
    erb :index
  end 

end 

get "/users/logout" do
  session.clear
  redirect '/'
end


#----POST---------------------------------------------------------

post "/login" do 
  puts params
  @user = User.login(params)
  session[:user_id] = @user.id
  puts session[:user_id]
  puts 
  puts 
  redirect "/secret_page"
end 

post "/create_user" do 
  @user = User.create(params[:user])
  session[:user_id] = @user.id 
  redirect '/secret_page'
end 

