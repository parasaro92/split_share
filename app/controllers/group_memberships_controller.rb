class GroupMembershipsController < ApplicationController

  def create
    @group = Group.find(params[:group_membership][:group_id])
    usr = User.find_by(email: params[:group_membership][:email])
    if usr
    begin
      @group.add(usr)
    rescue
      flash[:alert] = "Member is already user"
    else
      # Invite the user
      # Remember the user to join the group after adding to group
      flash[:notice] = "Member added successfully"
    end
  else
    flash[:alert] = "No such user"
  end
    redirect_to @group
  end
end
