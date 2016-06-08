require "rails_helper"

RSpec.feature "Photos", :type => :feature do

  scenario "A user uploads one photo and is taken to photos#index" do
    skip
    login_as(@@user_w_preps, :scope => :user)
    visit "/preps/#{@@user_w_preps.preps.last.id}/photos/new"
    attach_file('Pose', @@photo)
    find('#photo_tag').find(:xpath, "option[#{rand(1..10)}]").select_option
    # select('Front Relaxed', :from => 'photo_tag')
    click("Create Photo")
    expect(current_path).to eq "/preps/#{@@user_w_preps.preps.last.id}/photos"
    # expect Photo.last to be the new photo
  end

  scenario "Unauthenticated users cannot see photos" do
    visit "/preps/#{@@user_w_preps.preps.last.id}/photos/"
    expect(current_path).to eq "/home"
    expect(page).to have_text "SIGN IN"
  end

  scenario "Users can only see their own photos" do
    login_as(@@user, :scope => :user)
    visit "/preps/#{@@user_w_preps.preps.last.id}/photos/"
    expect(current_path).to eq "/"
    expect(page).to have_text "You are not authorized to do that"
  end

end
