class Admin::CreaturesController < Admin::BaseController
  before_action :find_creature, :only => [:show, :destroy]
  def index
    @creatures = Creature.order('created_at DESC').page(params[:page])
  end

  def show
  end

  def new
    @form = CreatureForm.new(Creature.new)
  end

  def create
    @form = CreatureForm.new(Creature.new)
    if @form.validate(params[:creature]) && @form.manually_save
      redirect_to admin_creatures_path, :notice => "Creature was created"
    else
      @form.build_subtype
      render :new
    end
  end

  def edit
    @form = CreatureForm.new(Creature.find(params[:id]))
  end

  def update
    @form = CreatureForm.new(Creature.find(params[:id]))
    if @form.validate(params[:creature]) && @form.manually_save
      redirect_to admin_creatures_path, :notice => "Creature was updated"
    else
      @form.build_subtype
      render :edit
    end
  end

  def destroy
    if @creature.delete
      redirect_to admin_creatures_path, :notice => "Creature was deleted"
    else
      redirect_to admin_creatures_path, :alert => "Creature wasn't deleted"
    end
  end

  private

  def find_creature
    @creature = Creature.find(params[:id])
  end
end
