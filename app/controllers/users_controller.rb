class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_user, except: %i[ create new index]
  before_action :require_same_user, only: %i[ edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 8)
  end

  # GET /users/1 or /users/1.json
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 10)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to articles_path, notice: "¡Bienvenid@ #{@user.username} a tus artículos!" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "Usuario editado con éxito" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] =  "El usuario y sus itinerarios han sido eliminados"
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user && !current_user.admin?
        flash[:alert] =  "No tienes permiso para realizar esta acción"
        redirect_to @user
        end
    end
end
