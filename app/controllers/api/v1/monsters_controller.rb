class Api::V1::MonstersController < Api::V1::BaseController

  # create monster /api/v1/monsters { monsters: {team_id: 1, name: 'Mon1', user_id: 1},
  # {team_id:1, user_id: 1, name: 'Mon2'} }
  def index
    if (user)
      respond_with user.monsters
    else
      respond_with "", json: {error: "User id is required!"}
    end
  end

  # create monster /api/v1/create_monster { monster: {team_id: 1, name: 'Mon1', user_id: 1}}
  def create_monster
    monster = Monster.create(monster_params)
    respond_with monster
  end

  # delete monster /api/v1/delete_monster {monster: {id: 1 }}
  def delete_monster
    unless monster.blank?
      monster.destroy
      respond_with "", json: {error: "Successfully deleted!"}
    else
      respond_with "", json: {error: "id is invalid!"}
    end
  end

  # update monster /api/v1/delete_monster {monster: {id: 1, name: 'Mon3', power: '1', team_id: 2} }
  def update_monster
    monster.update_attributes(monster_params)
    respond_with monster
  end

  private
  # get user info
  def user
    User.find(params["monster"]["user_id"]) if params["monster"]["user_id"]
  end

  # get monster by id
  def monster
    Monster.find(params["monster"]["id"]) if params["monster"]["id"]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def monster_params
    params.require(:monster).permit(:name, :power, :monster_type, :team_id, :user_id)
  end

  def team
    Team.find(params["monster"]["team_id"]) if params["monster"]["team_id"]
  end
end
