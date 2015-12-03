class GroupsController < ApplicationController

  def index
    @group = current_user.groups
  end
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.admin = current_user
    if @group.save
      redirect_to @group
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @members = @group.users
    @group_membership = @group.memberships.new
  end

private
  def group_params
    params.require(:group).permit(:name, :description)    
  end
end
