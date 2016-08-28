class Monster < ActiveRecord::Base
  MONSTER_CATEGORIES = %w(fire water earth electric wind)
  belongs_to :user, inverse_of: :monsters
  belongs_to :team, inverse_of: :monsters, counter_cache: true

  validates :name, presence: true, length: { maximum: 150 }
  validates :power, presence: true
  validates :user_id, :team_id, presence: true, allow_nil: true

  validates :monster_type, presence: true, inclusion: {in: MONSTER_CATEGORIES}
  # validates_associated :team, on: :create, message: 'validation fail'
  before_validation :available_monsters,  on: :create


  def available_monsters
    if user
      unless user.total_mosnters_count
        errors.add(:base, 'Reached the number of monsters')
      end
    end
  end
end
