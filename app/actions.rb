
get '/' do
  # We're going to pretend we're getting info
  # from the database
  bananas = {
    description: "$0.55 for #bananas at #Co-op",
    image: "http://nooga.com/assets/49173afcceda4c4327c23cd99fdb6a6839856.JPG",
    created_at: Date.today 
  }
  
  raisin_bran = {
    description: "$3.23 for 567g #RaisinBran at #Walmart",
    image: "http://s3.amazonaws.com/bncore/wp-content/uploads/2014/07/381351.jpg",
    created_at: Date.today.prev_day
  }
 
  yogurt = {
    description: "10x500ml #chobani #yogurts for $10 at #Sobeys",
    image: "https://www.referralcandy.com/wp-content/uploads/2016/04/chobani-in-stores.jpg",
    created_at: Date.today.prev_day.prev_day
  }
  
  @posts = [bananas, raisin_bran, yogurt] 
  erb :index
end
