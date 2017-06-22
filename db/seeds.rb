bananas = {
  description: "$0.55 for #bananas at #Co-op",
  image: "http://nooga.com/assets/49173afcceda4c4327c23cd99fdb6a6839856.JPG",
}

raisin_bran = {
  description: "$3.23 for 567g #RaisinBran at #Walmart",
  image: "http://s3.amazonaws.com/bncore/wp-content/uploads/2014/07/381351.jpg",
}

yogurt = {
  description: "10x500ml #chobani #yogurts for $10 at #Sobeys",
  image: "https://www.referralcandy.com/wp-content/uploads/2016/04/chobani-in-stores.jpg",
}

@posts = [bananas, raisin_bran, yogurt] 
 
@posts.each do |post|
    Post.create(post)
end