require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  let!(:user) do
    User.create(
      name: 'John Doe',
      posts_counter: 5,
      bio: 'A bio about John Doe'
    )
  end

  let!(:posts) do
    (1..5).map do |i|
      user.posts.create(
        title: "Post #{i}",
        text: "Post #{i} content",
        comments_counter: i,
        likes_counter: i
      )
    end
  end

  before do
    visit user_path(user)
  end

  it 'displays the user\'s profile picture' do
    expect(page).to have_css("img[src*='https://user-images.githubusercontent.com/']")
  end

  it 'displays the user\'s username' do
    expect(page).to have_css('h2.name', text: user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_css('h6.numberofposts', text: user.posts_counter.to_s)
  end

  it 'displays the user\'s bio' do
    expect(page).to have_css('h3.bio-title', text: 'Bio')
    expect(page).to have_css('p.bio-content', text: user.bio)
  end

  it 'displays the user\'s first 3 posts' do
    user.posts.order(created_at: :desc).limit(3).each do |post|
      expect(page).to have_css('h2.post-title', text: post.title)
      expect(page).to have_css('p.post-content', text: post.text)
      expect(page).to have_css('span.numberofcomments', text: post.comments_counter.to_s)
      expect(page).to have_css('span.numberoflikes', text: post.likes_counter.to_s)
    end
  end

  it "displays a button to view all of the user's posts" do
    expect(page).to have_link('Posts', href: user_posts_path(user))
  end

  it 'redirects to the user\'s post index page when clicking "Posts"' do
    within('.post', match: :first) do
      click_link 'Posts'
    end
    expect(current_path).to eq(user_posts_path(user))
  end
end
