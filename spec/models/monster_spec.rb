require 'rails_helper'

describe Monster, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:team) }
  it { should validate_presence_of(:name) }
  before :all do
    @user = create(:user)
    @team =  create(:team, name: 'Anser', user_id: @user.id)
  end

  describe '#aviable_monsters' do
    # let(:team) { build(:team, name: 'doremon', user_id: @user.id) }

    it 'validate monsters count per user' do
      4.times do |v|
        @team.monsters.create name: "monster_#{v}", user_id: @user.id
      end
      expect(@team.monsters.count).to eq 3
      expect(@team.errors.full_messages.join('')).to eq 'Monsters is invalid'
    end
  end

  describe '#delete_monster' do
    let(:monster)   { create(:monster, name: 'Benton', user_id: @user.id, team_id: @team.id) }
    let(:monster) { create(:monster, name: 'tom', user_id: @user.id, team_id: @team.id) }

    it 'destroy monster' do
      monster.delete
      expect(Monster.count).to eq 1
    end
  end

end
