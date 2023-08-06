class UserProjectRolesController < ApplicationController
  before_action :set_user_project_role, only: %i[ show edit update destroy ]

  # GET /user_project_roles or /user_project_roles.json
  def index
    @user_project_roles = UserProjectRole.all
  end

  # GET /user_project_roles/1 or /user_project_roles/1.json
  def show
  end

  # GET /user_project_roles/new
  def new
    @user_project_role = UserProjectRole.new
  end

  # GET /user_project_roles/1/edit
  def edit
  end

  # POST /user_project_roles or /user_project_roles.json
  def create
    @user_project_role = UserProjectRole.new(user_project_role_params)

    respond_to do |format|
      if @user_project_role.save
        format.html { redirect_to user_project_role_url(@user_project_role), notice: "User project role was successfully created." }
        format.json { render :show, status: :created, location: @user_project_role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_project_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_project_roles/1 or /user_project_roles/1.json
  def update
    respond_to do |format|
      if @user_project_role.update(user_project_role_params)
        format.html { redirect_to user_project_role_url(@user_project_role), notice: "User project role was successfully updated." }
        format.json { render :show, status: :ok, location: @user_project_role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_project_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_project_roles/1 or /user_project_roles/1.json
  def destroy
    @user_project_role.destroy

    respond_to do |format|
      format.html { redirect_to user_project_roles_url, notice: "User project role was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_project_role
      @user_project_role = UserProjectRole.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_project_role_params
      params.require(:user_project_role).permit(:user_id, :project_id, :role)
    end
end
