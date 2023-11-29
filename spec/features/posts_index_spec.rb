require 'rails_helper'

RSpec.describe 'User post index page', type: :feature do
  let!(:user) { User.create(name: 'John Doe', posts_counter: 0) }
  let!(:posts) do
    (1..10).map do |i|
      user.posts.create(title: "Post #{i}", text: "Post #{i} content")
    end
  end

  before do
    visit user_posts_path(user)
  end

  it "displays the user's profile picture" do
    expect(page).to have_css("img[src*='https://user-images.githubusercontent.com/']")
  end

  it "displays the user's username" do
    expect(page).to have_content(user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_css('h5', text: '#Number of posts:')
    expect(page).to have_css('h6.numberofposts', text: user.posts_counter.to_s)
  end
  it "displays a post's title and some of the post's body" do
    posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text.truncate(50))
    end
  end

  it 'displays the first comments on a post and how many comments it has' do
    posts.each do |post|
      expect(page).to have_css("h5:contains('Comments:')")
      expect(page).to have_css('span.numberofcomments', text: post.comments_counter.to_s)
    end
  end

  it 'displays how many likes a post has' do
    posts.each do |post|
      expect(page).to have_content('Likes:')
      expect(page).to have_selector('span.numberoflikes', text: post.likes_counter.to_s)
    end
  end

  it "redirects to a post's show page when clicking on a post" do
    click_link 'View', href: user_post_path(user, posts.first)
    expect(page).to have_content('Add Comment')
  end

  it 'displays paginated posts with 10 posts per page' do
    # Create more than 10 posts
    (1..15).map do |i|
      user.posts.create(title: "Post #{i}", text: "Post #{i} content")
    end

    # Visit the user's posts page
    visit user_posts_path(user)

    # Initial page should have 10 posts
    expect(page).to have_selector('.post', count: 10)

    # Check that the total number of posts is greater than what's displayed on the page
    total_posts = Post.count
    expect(total_posts).to be > 10

    # Capture the content of the first page posts
    first_page_posts_content = page.all('.post').map(&:text)

    # Click on 'Next' to go to the second page
    click_on('Next')

    # Capture the content of the second page posts
    second_page_posts_content = page.all('.post').map(&:text)

    # Ensure that the posts on the second page are different from the first page
    expect(second_page_posts_content).not_to eq(first_page_posts_content)
  end
end
