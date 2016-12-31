require "rails_helper"

RSpec.feature "Sign up", :type => :feature do

  scenario "New user signs in" do
    email = Faker::Internet.email
    password = Faker::Internet.password(8)
    visit "/users/sign_up"
    fill_in "Name",                   :with => Faker::Internet.name
    fill_in "Email",                  :with => email
    fill_in "user_password",          :with => password
    fill_in "Password confirmation",  :with => password
    click_button "Sign up"
    expect(User.last.email).to eq(email)
    expect(page).to have_text("Your Account")
  end

  scenario "Prepless existing user logs in and sees account page" do
    visit "/users/sign_in"
    fill_in "Email",    :with => @@user.email
    fill_in "Password", :with => "pancakes"
    click_button "Log in"
    expect(current_path).to eq "/"
    expect(page).to have_text("Your Account")
  end

  scenario "Prepped existing user logs in and sees prep show" do
    skip
    visit "/users/sign_in"
    fill_in "Email",    :with => @@user_w_preps.email
    fill_in "Password", :with => "pancakes"
    click_button "Log in"
    expect(current_path).to eq "/"
    expect(page).to have_text "weeks from #{@@user_w_preps.preps.last.contests.first.title}"
  end

  scenario "Logged in user redirects to root on sign up" do
    login_as(@@user, :scope => :user)
    visit "/users/sign_up"
    expect(current_path).to eq "/"
    expect(page).to have_text "You are already signed in"
  end

  scenario "Logged in user redirects to root on log in" do
    login_as(@@user, :scope => :user)
    current_user = User.first
    visit "/users/sign_in"
    expect(current_path).to eq "/"
    expect(page).to have_text "You are already signed in"
  end
end
