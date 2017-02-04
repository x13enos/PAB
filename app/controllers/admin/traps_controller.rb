class Admin::TrapsController < Admin::BaseController
  before_action :find_trap, :only => [:show, :edit, :update, :destroy]
  def index
    @traps = Trap.order('created_at DESC').page(params[:page])
  end

  def show
  end

  def new
    @trap = Trap.new
  end

  def create
    @trap = Trap.new(trap_attributes)
    if @trap.save
      redirect_to admin_traps_path, :notice => "Trap was created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @trap.update(trap_attributes)
      redirect_to admin_traps_path, :notice => "Trap was updated"
    else
      render :edit
    end
  end

  def destroy
    if @trap.delete
      redirect_to admin_traps_path, :notice => "Trap was deleted"
    else
      redirect_to admin_traps_path, :alert => "Trap wasn't deleted"
    end
  end

  private

  def find_trap
    @trap = Trap.find(params[:id])
  end

  def trap_attributes
    params.require(:trap).permit(:name, :challenge_rating, :experience, :type_of_system, :reset, :trigger, :perception,
                                 :disable_devise, :effect, :description)
  end
end
