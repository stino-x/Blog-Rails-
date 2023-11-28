require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  let!(:users) do
    [
      User.create(name: 'John Doe', posts_counter: 2),
      User.create(name: 'Jane Smith', posts_counter: 5),
      User.create(name: 'Bob Johnson', posts_counter: 3)
    ]
  end

  before do
    visit users_path
  end

  it 'displays the username of all other users' do
    users.each do |user|
      expect(page).to have_css('.name', text: user.name)
    end
  end

  it 'displays the profile picture for each user' do
    users.each do |_user|
      expect(page).to have_css("img[src*='user-images.githubusercontent.com']", count: users.size)
    end
  end

  it 'displays the number of posts each user has written' do
    users.each do |user|
      expect(page).to have_css('.numberofposts', text: user.posts_counter.to_s)
    end
  end

  it 'redirects to the user show page when clicking on a user' do
    users.each do |user|
      click_link 'View', href: user_path(user)
      expect(page).to have_css('h2', text: user.name) # Assuming your user show page has an h2 tag with the user's name
      expect(current_path).to eq(user_path(user))
      visit users_path # Go back to the index page for the next iteration
    end
  end
end
