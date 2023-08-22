class ProjectsController < ApplicationController
  load_and_authorize_resource

  # GET /projects or /projects.json
  def index
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.workflow = JSON.parse(@project.workflow) if @project.workflow.is_a?(String)

    create_default_tags

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def select
    u = current_user
    u.current_project = @project
    u.save!

    redirect_to root_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :shortname, :workflow, :approvals, :areas, :boards, :severities)
  end

  def create_default_tags
    if @project.approvals
      approval = TagGroup.find_by!(name: TagGroup::APPROVAL_NAME_NAME)

      TagGroup::APPROVAL_DEFAULT_TAG_NAMES.each do |tag_name|
        create_tag_with_tag_group tag_name, @project, approval
      end
    end

    if @project.severities
      severity = TagGroup.find_by!(name: TagGroup::SEVERITY_NAME)

      TagGroup::SEVERITY_DEFAULT_TAG_NAMES.each do |tag_name|
        create_tag_with_tag_group tag_name, @project, severity
      end
    end
  end

  def create_tag_with_tag_group(name, project, tag_group)
    t = Tag.new
    t.tag_group = tag_group
    t.name = name
    t.project = project
    critical.save!
    critical
  end
end
