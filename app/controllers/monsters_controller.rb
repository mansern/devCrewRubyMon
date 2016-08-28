class MonstersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_monster, only: [:show, :edit, :update, :destroy]

  # GET /monsters
  # GET /monsters.json
  def index
    @monsters = Monster.all
  end

  # GET /monsters/1
  # GET /monsters/1.json
  def show
  end

  # GET /monsters/new
  def new
    @monster = Monster.new
  end

  # GET /monsters/1/edit
  def edit
  end

  # POST /monsters
  # POST /monsters.json
  def create
    get_team
    @monster = @team.monsters.build(monster_params)
    @monster.user = current_user
    if @monster.save
      redirect_to @monster, notice: "Monster #{@monster.name} was successfully created."
    else
      redirect_to @monster
      flash[:error] = @monster.errors.full_messages.join('')
    end
  end

  # PATCH/PUT /monsters/1
  # PATCH/PUT /monsters/1.json
  def update
    respond_to do |format|
      if @monster.update(monster_params)
        format.html { redirect_to @monster, notice: 'Monster was successfully updated.' }
        format.json { render :show, status: :ok, location: @monster }
      else
        format.html { render :edit }
        format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monsters/1
  # DELETE /monsters/1.json
  def destroy
    @monster.destroy
    respond_to do |format|
      format.html { redirect_to monsters_url, notice: 'Monster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monster
      @monster ||= Monster.find(params[:id]) if params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monster_params
      params.require(:monster).permit(:name, :power, :monster_type, :team_id)
    end

    def get_team
      @team ||= Team.find(params[:monster][:team_id]) if params[:monster][:team_id]
    end

end
