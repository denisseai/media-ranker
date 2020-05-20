class VotesController < ApplicationController
  before_action :require_login, only: [:upvote]

  def upvote
    @work_id = params[:work_id]
    vote = Vote.new
    vote.work_id = @work_id
    vote.user_id = @current_user.id

    if Vote.check_exisiting_vote(@current_user.id, @work_id)
      flash[:error] = "User: has already voted for this work"
      redirect_back(fallback_location: root_path)
    else 
      vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: root_path)
      #redirect_to :back
    end
  end
end
