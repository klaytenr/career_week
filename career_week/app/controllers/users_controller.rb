class UsersController < ApplicationController

  skip_before_action :check_log_in, only: [:login, :register, :create, :enter, :logout, :code, :check_in]
  def login
    # login page
    puts 'login'
    
  end

  def register
    # register page
    print 'register'
    
  end

  def edit
    # edit profile page
    @user = User.find(session[:user_id])
  end

  def enter 
    # login process
    print 'enter'
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if @user.level == 9
        session[:code] = Code.last().content
        redirect_to "/dashboard"
      else
        redirect_to "/code"
      end 
    else
      flash[:error] = ["Invalid Combination"]
      redirect_to :back
    end
  end

  def create
    # register process
    print 'create'
    @user = User.create(user_params)
    if @user.save
      if User.first() == @user 
        @user.level = 9
        @user.save 
      end 
      session[:user_id] = @user.id
      if @user.level == 9
        session[:code] = Code.last().content
        redirect_to "/dashboard"
      else
        redirect_to "/code"
      end 
    else
      flash[:error] = @user.errors.full_messages
      redirect_to :back
    end
  end 

  def code 
    @user = User.find(session[:user_id])
    @code = Code.last()
    @time = @code.created_at.in_time_zone("Pacific Time (US & Canada)").strftime("%A %b %e At %l:%M %p")
  end 

  def code_generate
    @user = User.find(session[:user_id])
    @code = Code.create(content: [*('a'..'z'),*('0'..'9')].shuffle[0,4].join, user: @user)
    if @code.save
      redirect_to "/dashboard"
    else
      flash[:error] = @code.errors.full_messages
      redirect_to :back
    end
  end

  def dashboard
    # home page
    @user = User.find(session[:user_id])
    @code = Code.last()
    @time = @code.created_at.in_time_zone("Pacific Time (US & Canada)").strftime("%A %b %e At %l:%M %p")
    @posts = Post.all()
  end 

  def post
    # post message
    @user = User.find(session[:user_id])
    @post = Post.create(content: params[:content], user: @user)
    if @post.save
      redirect_to "/dashboard"
    else
      flash[:error] = @post.errors.full_messages
      redirect_to :back
    end
  end 

  def view
    # go to user's profile
    @user = User.find(session[:user_id])
  end 

  def view_all
    # see all users
    @user = User.find(session[:user_id])

  end 

  def change 
    # edit user information
    @user = User.find(params[:user_id])
    if @user.update(first_name: params[:first_name],last_name: params[:last_name], email: params[:email])
      redirect_to "/dashboard"
    else 
      flash[:error] = [@user.errors]
      redirect_to :back 
    end 
  end 

  def check_in 
    # process of checking in
    @user = User.find(session[:user_id])
    if params[:code] == Code.last().content
      session[:code] = Code.last().content
      redirect_to '/dashboard'
    else
      flash[:error] = ["That code is not the latest code. Try again"]
      redirect_to :back 
    end
  end 

  def attendance 
    # page to see who has checked in
    @user = User.find(session[:user_id])

  end 

  def destroy_one_user
    # delete one user
    @user = User.find(params[:user_id])

  end 

  def destroy_one_post
    # delete one user
    @user = User.find(session[:user_id])
    @post = Post.find(params[:post_id])
    @post.destroy
    redirect_to '/dashboard'
  end 

  def destroy_all_users
    # delete all users
    @user = User.find(session[:user_id])

  end 

  def destroy_all_posts 
    @user = User.find(session[:user_id])

  end 

  def logout 
    reset_session
    print session
    redirect_to "/"
  end 

  private 

  def user_params 
    params.require(:user).permit(:first_name, :last_name, :level, :email, :password, :password_confirmation)
  end 
end
