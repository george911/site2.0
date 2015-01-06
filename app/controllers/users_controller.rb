class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!,only: [:new,:create] #devise认证user
  # GET /users
  # GET /users.json
  def index
    session[:build_sum] = false
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if current_user != nil
      @review = @user.reviews.present? ? (@user.reviews.find_by(author_id:current_user.id) or Review.new) : Review.new
    else
      @review = Review.new
    end
    case @user.user_type
    when "猎头"
      render 'hunter'
    when "求职者"
      render 'talent'
    end
    
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
    params.require(:user).permit(
      :tag_list,
      :avatar,
      :mobile, :user_name, :true_name, :user_type, :email, :birthday,
      :base_salary, :month_num, :bonus, :housing, :transport, :stock,:stock_num, 
      :retention_bonus, :expect_package, :expect_month_salary,
      :title,summaries_attributes: [:user_id, :content, :_destroy],
      educations_attributes: [:user_id, :school, :enter_school, :leave_school,
      :major, :degree, :_destroy],
      works_attributes: [:user_id, :title,:employer,:join_date,:leave_date,:industry, :job_scope, :_destroy]
     )
    end
end
