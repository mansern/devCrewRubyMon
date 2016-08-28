class User < ActiveRecord::Base

  TOTAL_MONSTERS = 20
  TOTAL_TEAMS = 3

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :teams, dependent: :destroy
  has_many :monsters, dependent: :destroy

  def total_team_member
    self.teams.count < TOTAL_TEAMS
  end

  def total_mosnters_count
    self.monsters.count < TOTAL_MONSTERS
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
    end
  end
end
