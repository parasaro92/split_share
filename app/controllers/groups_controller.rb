class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @group = Group.all
  end
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.admin = current_user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

private
  def group_params
    params.require(:group).permit(:name, :description)    
  end
end
