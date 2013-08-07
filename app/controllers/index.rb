get '/' do
  # Look in app/views/index.erb
  erb :index
end

get "/create" do 

  erb :create_user
end 

get "/users/logout" do
  session.clear
  redirect '/'
end
get "/users/:id" do
  if current_user
    @user = User.find(params[:id])
    if @user.id == session[:user_id]
      @urls = @user.urls.all
      erb :profile
    else
      @error = "Nice try"
    end
  else
    @error = "you gotta login, ya chancho."
    erb :index
  end 

end 



#----POST---------------------------------------------------------

post "/login" do 
  puts params
  @user = User.login(params)
  session[:user_id] = @user.id
  puts session[:user_id]
  puts 
  puts 
  redirect "/users/#{@user.id}"
end 

post "/create_user" do 
  @user = User.create(params[:user])
  session[:user_id] = @user.id 
  redirect "/users/#{@user.id}"
end 

