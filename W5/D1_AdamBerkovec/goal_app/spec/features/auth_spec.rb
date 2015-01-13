# spec/features/auth_spec.rb
require 'rails_helper'
require 'spec_helper'

feature "the signup process" do
  username = create_user
  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    before(:each) do
      sign_up_user(username)
    end

    scenario "redirect to show page" do
      expect(page).to have_content "Welcome"
    end

    scenario "shows username on show page" do
      expect(page).to have_content username
    end
  end

  feature "logging in and out" do
    before(:each) do
      sign_up_user(username)
      sign_in_user(username)
    end

    scenario "shows username and greeting on homepage after login" do
      expect(page).to have_content "Welcome"
      expect(page).to have_content username
    end


    scenario "Logs user out" do
      click_button "Sign Out"
    end

    scenario "Redirects to New Session Page" do
      click_button "Sign Out"
      expect(page).to have_content "Username"
      expect(page).to have_content "Password"
    end
  end

  feature "CRUD actions for goals" do
    before(:each) do
      sign_up_user(username)
      sign_in_user(username)
    end

    scenario "Go to goal page and save" do
      click_on "Create Goal"
      expect(page).to have_content "New Goal"
      expect(page).to have_content "Title"
      expect(page).to have_content "Details"
      create_goal
    end

    scenario "redirect to goal page" do
      create_goal
      user = User.find_by(username: username)
      visit user_url(user)
      expect(page).to have_content "title"
      expect(page).to have_content "details"
      expect(page).to have_button "Edit Goal"
    end

    scenario "Redirects to edit page" do
      create_goal
      user = User.find_by(username: username)
      visit user_url(user)
      click_button "Edit Goal"
      expect(page).to have_content "Edit Goal"
      expect(page).to have_content "Title"
      expect(page).to have_content "Details"
      expect(page).to have_button "Update Goal"
    end

    scenario "destroy goal" do
      create_goal
      user = User.find_by(username: username)
      visit user_url(user)
      expect(page).to have_button "Delete Goal"
      click_button "Delete Goal"
      expect(page).to_not have_content "title"
    end

    scenario "expect to update a goal to completed" do
      create_goal
      user = User.find_by(username: username)
      visit edit_goal_url(user.goals.first)
      choose "Completed"
      click_button "Update Goal"
      expect(page).to have_content "Completed"
    end
  end
end
