class UsersController < ApplicationController
  before_action :authorize_request
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    users = User.all
    render json: { status: :ok, data: users }
  end

  # GET /users/1 or /users/1.json
  def show
    render json: { status: :ok, data: @current_user }
  end

  # POST /users or /users.json
  def create
    # @user = User.new(user_params)

    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to user_url(@user), notice: "User was successfully created." }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    # respond_to do |format|
    #   if @user.update(user_params)
    #     format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
    #     format.json { render :show, status: :ok, location: @user }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    # User.destroy(2)

    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @current_user = User.find(helpers.get_user_id)
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
    end
end
