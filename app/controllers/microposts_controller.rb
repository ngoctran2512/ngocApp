class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
   before_action :correct_user,   only: :destroy
  before_action :load_micropost, only: :show
  before_action :load_user, only: :index
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
     flash[:success] = "Micropost created!"
      redirect_to :back
    else
     @feed_items = [] 
     render 'static_pages/home'
   end
  end

  #def show
   # @micropost = Micropost.find(params[:id])
    
  #end
  def index
    @microposts = Micropost.paginate(page: params[:page], per_page: 5)
  end
  def edit
    @micropost = Micropost.find(params[:id])
  end
   def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
   end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    def load_micropost
      @micropost = Micropost.find(params[:id])
    end

    def load_user
      @user = User.find {params[:id]}
    end
end