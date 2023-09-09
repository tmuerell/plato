class ProjectGroupMappingsController < ApplicationController
  before_action :set_project_group_mapping, only: %i[ show edit update destroy ]

  # GET /project_group_mappings or /project_group_mappings.json
  def index
    @project_group_mappings = ProjectGroupMapping.all
  end

  # GET /project_group_mappings/1 or /project_group_mappings/1.json
  def show
  end

  # GET /project_group_mappings/new
  def new
    @project_group_mapping = ProjectGroupMapping.new
  end

  # GET /project_group_mappings/1/edit
  def edit
  end

  # POST /project_group_mappings or /project_group_mappings.json
  def create
    @project_group_mapping = ProjectGroupMapping.new(project_group_mapping_params)

    respond_to do |format|
      if @project_group_mapping.save
        format.html { redirect_to project_group_mapping_url(@project_group_mapping), notice: "Project group mapping was successfully created." }
        format.json { render :show, status: :created, location: @project_group_mapping }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project_group_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_group_mappings/1 or /project_group_mappings/1.json
  def update
    respond_to do |format|
      if @project_group_mapping.update(project_group_mapping_params)
        format.html { redirect_to project_group_mapping_url(@project_group_mapping), notice: "Project group mapping was successfully updated." }
        format.json { render :show, status: :ok, location: @project_group_mapping }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project_group_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_group_mappings/1 or /project_group_mappings/1.json
  def destroy
    @project_group_mapping.destroy

    respond_to do |format|
      format.html { redirect_to project_group_mappings_url, notice: "Project group mapping was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_group_mapping
      @project_group_mapping = ProjectGroupMapping.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_group_mapping_params
      params.require(:project_group_mapping).permit(:project_id, :group, :role)
    end
end
