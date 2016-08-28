require 'rails_helper'

feature 'User features' do
  given(:user)         { create(:user) }
  given(:another_user) { create(:user) }

  background :each do
    sign_in_with(user.email, user.password)
  end

  scenario 'User successful log in and see hello message' do
    expect(page).to have_content "Hello, #{user.email}"
  end

  scenario 'The user creates a team' do
    create_team

    expect(page).to have_content 'Team Doremon created'
    expect(page).to have_link 'Edit Team' 
    expect(page).to have_link 'Delete Team'
    expect(page).to have_link 'Your Team'
  end

  scenario 'The user update a team' do
    create_team

    click_on 'Edit Team'
    fill_in 'Team name', with: 'Anser'

    click_on 'Update Team'
    expect(page).to have_content 'Anser updated'
  end

  scenario 'The user delete a team' do
    create_team

    click_on 'Delete Team'
    expect(page).to have_content 'Doremon Deleted'
    expect(page).to have_link 'Create Team'
  end

  scenario 'another_user can`t edit users team' do
    create_team
    id = Team.last.id

    click_on 'Logout'
    sign_in_with(another_user.email, another_user.password)

    visit edit_team_path(id)
    expect(page).to have_content 'You do not have permission for this action.'
  end
end
