 class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
   before_action :correct_user,   only: :destroy
 
  def new
       @comment = Comment.new
  end
  def create
    @micropost = Micropost.find_by id: params[:id]
    @comment = @micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
 	  # binding.pry
    if @comment.save
     
       redirect_to @micropost
    else
      render "shared/_comment_form"
    end
  end
   private

    def comment_params

      params.require(:comment).permit(:content, :micropost_id, :user_id)
    end
     def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)

  end
end