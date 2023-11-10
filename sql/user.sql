first_user = User.create(name: 'Tom', bio: 'Teacher from Mexico.', photo: 'https://unsplash.com/photos/F_-0BxGuVvo')
second_user = User.create(name: 'Lilly', bio: 'Teacher from Poland.', photo: 'https://unsplash.com/photos/F_-0BxGuVvo')
new_user1 = User.create(name: 'First User', bio: 'Some bio...', photo: 'new_user1_photo_url')
new_user2 = User.create(name: 'Second User', bio: 'Passionate developer exploring the world of coding.', photo: 'new_user2_photo_url')

-- to see all users
all_users = User.all

all_users.each do |user|
  puts "User ID: #{user.id}, Name: #{user.name}, Bio: #{user.bio}"
end
