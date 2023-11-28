require 'rails_helper'

RSpec.describe 'User post show page', type: :feature do
  let!(:user) { User.create(name: 'John Doe') }
  let!(:post) { user.posts.create(title: 'Test Post', text: 'This is a test post') }
  let!(:comment1) { post.comments.create(user:, text: 'Comment 1') }
  let!(:comment2) { post.comments.create(user:, text: 'Comment 2') }
  let!(:like) { post.likes.create(user:) }

  before do
    visit user_post_path(user, post)
  end

  it "displays the post's title" do
    expect(page).to have_css('.post-title', text: "Post ##{post.id} by #{post.author.name}")
  end

  it 'displays who wrote the post' do
    expect(page).to have_content("Post ##{post.id} by #{post.author.name}")
  end

  it 'displays how many comments the post has' do
    expect(page).to have_css('.sign', text: 'Comments:')
    expect(page).to have_css('span.numberofcomments', text: post.comments_counter.to_s)
  end

  it 'displays how many likes the post has' do
    expect(page).to have_css('h5', text: 'Likes:')
    expect(page).to have_css('span.numberoflikes', text: post.likes_counter.to_s)
  end

  it 'displays the post body' do
    expect(page).to have_css('.post-content', text: post.text)
  end

  it 'displays the username of each commenter' do
    post.comments.each do |comment|
      expect(page).to have_css('.commenter', text: comment.user.name)
    end
  end

  it 'displays the comment each commenter left' do
    post.comments.each do |comment|
      expect(page).to have_css('.comment-content', text: comment.text)
    end
  end
end
