class Team < ActiveRecord::Base
  belongs_to :user
  has_many :monsters, dependent: :destroy, inverse_of: :team

  validates :name, presence: true, uniqueness: true, length: { in: 2..150 }
  validates :user_id, presence: true
  validate :available_teams, on: :create
  # validates :monsters_count, numericality: { less_than: :monsters_limit }, on: :create

  private
  def available_teams
    unless user.total_team_member
      errors.add(:base, 'Team limit has been reached!')
    end
  end
end
