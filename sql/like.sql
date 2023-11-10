# Create Likes for Posts
like1 = Like.create(user_id: new_user1.id, post_id: new_post1.id)
like2 = Like.create(user_id: new_user1.id, post_id: new_post2.id)
like3 = Like.create(user_id: new_user2.id, post_id: new_post2.id)
like4 = Like.create(user_id: new_user2.id, post_id: new_post3.id)
like5 = Like.create(user_id: new_user1.id, post_id: new_post4.id)
like6 = Like.create(user_id: new_user1.id, post_id: new_post4.id)
like7 = Like.create(user_id: new_user1.id, post_id: new_post5.id)
like8 = Like.create(user_id: new_user2.id, post_id: new_post5.id)
like9 = Like.create(user_id: new_user2.id, post_id: new_post6.id)

# Display Likes for Posts
puts "Likes for Post #{new_post1.id}: #{new_post1.likes.count}"
puts "Likes for Post #{new_post2.id}: #{new_post2.likes.count}"
puts "Likes for Post #{new_post3.id}: #{new_post3.likes.count}"
puts "Likes for Post #{new_post4.id}: #{new_post4.likes.count}"
puts "Likes for Post #{new_post5.id}: #{new_post5.likes.count}"
puts "Likes for Post #{new_post6.id}: #{new_post6.likes.count}"
