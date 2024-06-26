class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]

    def index
        @microposts = @user.microposts.paginate(page: params[:page]).per(10)
      end

    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
          flash[:success] = "Micropost created!"
          redirect_to root_url
        else
          @feed_items = []
          render 'static_pages/home'
        end 
    end
    private
        def micropost_params
            params.require(:micropost).permit(:content)
        end
end
