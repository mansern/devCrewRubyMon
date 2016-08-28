require 'rails_helper'

describe Team, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:monsters) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_length_of(:name).is_at_most(150) }

  before :each do
    @user =  create(:user)
    @team =  create(:team, name: 'Anser', user_id: @user.id)
  end

  describe 'team belongs_to user' do
    it 'team should belongs_to user' do
      expect(@team.user).to eq @user 
    end
  end

  describe 'validation monsters count team' do
    it '#aviable_monsters' do
      expect(@team.monsters_limit).to eq 3
    end
  end

end
