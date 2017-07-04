helpers do
  def logged_in?
    !session[:user_id].nil?       
  end
end

get '/' do
  @posts = Post.order(created_at: :desc)
  erb :index
end


get '/new' do
  @post = Post.new
  erb :new
end

post '/post' do
  @post = Post.new
  
  @post.description = params[:description]
  
  # Move file into storage
    # Move file into storage
  if params[:image]
    tempfile = params[:image][:tempfile] 
    filename = params[:image][:filename] 
    filepath = "uploads/#{filename}"
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