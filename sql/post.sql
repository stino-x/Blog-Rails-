post1 = Post.create(author_id: user.id, title: 'First Post', text: 'This is the content of the first post.')
post2 = Post.create(author_id: user.id, title: 'Second Post', text: 'This is the content of the second post.')
post3 = Post.create(author_id: user.id, title: 'Third Post', text: 'This is the content of the third post.')
post4 = Post.create(author_id: user.id, title: 'Fourth Post', text: 'This is the content of the fourth post.')


new_post1 = Post.create(author_id: new_user1.id, title: 'Hello', text: 'This is my first post.')
new_post2 = Post.create(author_id: new_user1.id, title: 'Greetings', text: 'This is my second post.')
new_post3 = Post.create(author_id: new_user1.id, title: 'Introduction', text: 'This is my third post.')

new_post4 = Post.create(author_id: new_user2.id, title: 'Coding Journey', text: 'Exploring the world of coding.')
new_post5 = Post.create(author_id: new_user2.id, title: 'Tech Enthusiast', text: 'Embracing the latest tech trends.')
new_post6 = Post.create(author_id: new_user2.id, title: 'Learning Adventures', text: 'Sharing my learning adventures.')

----- deleting a post
Post.find_by(id: new_post2.id)
# Find the post by its ID
post_to_delete = Post.find_by(id: new_post2.id)

# Check if the post exists
if post_to_delete
  # Delete the post
  post_to_delete.destroy
  puts "Post deleted successfully!"
else
  puts "Post not found."
end
