require 'rails_helper.rb'

feature 'Creating posts' do
  scenario 'can create a post' do
    visit '/'
    click_link 'New Post'
    attach_file('Image', "spec/files/images/burger.jpg")
    fill_in 'Caption', with: 'love me some #meat'
    click_button 'Create Post'
    expect(page).to have_content('#meat')
    expect(page).to have_css("img[src*='burger.jpg']")
  end

  it 'needs an image to create a post' do
    # visit root route
    visit '/'
    # click the 'New Post' link
    click_link 'New Post'
    # fill in the caption field (without touching the image field)
    fill_in 'Caption', with: 'No picture just yet'
    # click the 'Create Post' button
    click_button 'Create Post'
    # expect the page to say, "Halt, you fiend! You need an image to post here!"
    expect(page).to have_content('Fiesty one, you are...must have an image to continue')
  end
end
