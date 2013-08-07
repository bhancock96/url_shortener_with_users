# get '/' do
#   @urls = Url.all
#   erb :index
# end
get '/url/:short_url' do
  @url = Url.find_by_short_url(params[:short_url])
  erb :url
end

get '/:short_url' do   
  @url = Url.find_by_short_url(params[:short_url])
  @count = @url.click_count
  @new_count = @count + 1 
  @url.click_count = @new_count
  @url.save
  redirect "#{@url.name}"
end

post '/urls' do
  # short_url = SecureRandom.hex(4)
  @url = Url.create(name: params[:url])
  redirect "/url/#{@url.short_url}"
end

post '/user/:id/urls' do
  @user = User.find(session[:user_id])
  @user.urls.create(name: params[:url])
  redirect "/users/#{@user.id}"
end
