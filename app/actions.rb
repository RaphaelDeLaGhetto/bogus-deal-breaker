helpers do
  def logged_in?
    !session[:user_id].nil?       
  end
  
  def current_user
    if logged_in?
      User.find(session[:user_id])
    end
  end
end

['/new', '/post/:id/edit'].each do |path|
  before path do
    redirect '/login' if !logged_in?
  end
end

#
# GET /
#
get '/' do
  @posts = Post.order(created_at: :desc)
  erb :index
end

#
# GET /new
#
get '/new' do
  @post = Post.new
  erb :new
end

#
# POST /post
#
post '/post' do
  @post = Post.new
  
  @post.description = params[:description]
  @post.user_id = session[:user_id]
  
  # Move file into storage
  if params[:image]
    tempfile = params[:image][:tempfile] 
    filename = params[:image][:filename] 
    filepath = "/uploads/#{filename}"
    @post.image = filepath
    filepath = "public/#{filepath}"
    FileUtils.cp(tempfile.path, filepath)
  end
  
  if @post.save
    redirect '/'
  else
    erb :new
  end
end

#
# GET /post/:id
#
get '/post/:id' do
  @post = Post.find(params[:id])
  erb :show
end

#
# GET /post/:id/edit
#
get '/post/:id/edit' do
  @post = Post.find(params[:id])
  if @post.user == current_user 
    erb :edit
  else
    @ip = request.ip
    halt(401, erb(:error_401))
  end
end

#
# PATCH /post/:id
#
patch '/post/:id' do
  @post = Post.find(params[:id])
  @post.description = params[:description]
  if @post.save
    redirect "/post/#{@post.id}"
  else
    erb :edit 
  end
end

#
# DELETE /post/:id
#
delete '/post/:id' do
 
  #if params[:id] == session[:user_id]
  @post = Post.find(params[:id])
  if @post.user == current_user
    Post.delete(params[:id])
    redirect('/')
  else
    @ip = request.ip
    halt(401, erb(:error_401))
  end
end



get '/login' do
  @user = User.new
  erb :login
end

post '/login' do
  @user = User.find_by_email(params[:email])
  if @user.password == params[:password]
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :login
  end
end

get '/logout' do
  session.clear
  redirect '/'
end