class GroupMembershipsController < ApplicationController

  def create
    @group = Group.find(params[:group_membership][:group_id])
    email = params[:group_membership][:email]
    usr = User.find_by(email: email)
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
      if email.match(Devise.email_regexp)
        invited_user = User.invite!(:email => email)
        invited_user.invited_group = @group
        invited_user.save!
        # Remember the user to join the group after adding to group
        flash[:alert] = "No such user"
      else
        flash[:alert] = "Please enter proper email address"
      end
    end
    redirect_to @group
  end
end