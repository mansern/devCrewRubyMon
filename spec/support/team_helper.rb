module TeamsHelpers
  def create_team
    visit root_path
    click_on 'Create Team'
    fill_in 'Team name', with: 'Doremon'

    click_button 'Create Team'
  end
end
