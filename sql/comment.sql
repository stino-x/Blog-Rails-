comment1 = Comment.create(post_id: new_post1.id, user_id: new_user2.id, text: 'Great first post!')
comment2 = Comment.create(post_id: new_post2.id, user_id: new_user2.id, text: 'Interesting thoughts!')
comment3 = Comment.create(post_id: new_post3.id, user_id: new_user2.id, text: 'Looking forward to more posts!')

comment4 = Comment.create(post_id: new_post4.id, user_id: new_user1.id, text: 'Good luck on your coding journey!')
comment5 = Comment.create(post_id: new_post5.id, user_id: new_user1.id, text: 'Tech enthusiast here too!')
comment6 = Comment.create(post_id: new_post6.id, user_id: new_user1.id, text: 'Learning together is always fun!')


-- editing a comment

existing_comment = Comment.find_by(id: comment1.id)
existing_comment.update(text: 'Updated comment content')