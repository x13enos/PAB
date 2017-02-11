class Admin::CreaturesController < Admin::BaseController
  before_action :find_creature, :only => [:show, :edit, :update, :destroy]
  def index
    @creatures = Creature.order('created_at DESC').page(params[:page])
  end

  def show
  end

  def new
    @creature = Creature.new
    build_subtype
  end

  def create
    @creature = Creature.new(creature_attributes)
    if @creature.save
      redirect_to admin_creatures_path, :notice => "Creature was created"
    else
      build_subtype
      render :new
    end
  end

  def edit
    build_subtype
  end

  def update
    if @creature.update(creature_attributes)
      redirect_to admin_creatures_path, :notice => "Creature was updated"
    else
      build_subtype
      render :edit
    end
  end

  def destroy
    if @creature.delete
      redirect_to admin_creatues_path, :notice => "Creature was deleted"
    else
      redirect_to admin_creatues_path, :alert => "Creature wasn't deleted"
    end
  end

  private

  def find_creature
    @creature = Creature.find(params[:id])
  end

  def build_subtype
    last_subtype = @creature.subtypes.last
    @creature.subtypes << "" if last_subtype.nil? || !last_subtype.empty?
  end

  def creature_attributes
    params.require(:creature).permit(:name, :challenge_rating, :experience, :active, :class_name,
                                     :alignment, :size, :reach, :init, :sense, :perception, :race,
                                     :type_name, :subtypes => [])
  end
end
