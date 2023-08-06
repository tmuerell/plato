class CustomerProjectsController < ApplicationController
  load_and_authorize_resource

  # GET /customer_projects or /customer_projects.json
  def index
  end

  # GET /customer_projects/1 or /customer_projects/1.json
  def show
  end

  # GET /customer_projects/new
  def new
    @customer_project = CustomerProject.new
  end

  # GET /customer_projects/1/edit
  def edit
  end

  # POST /customer_projects or /customer_projects.json
  def create
    @customer_project = CustomerProject.new(customer_project_params)

    respond_to do |format|
      if @customer_project.save
        format.html { redirect_to customer_project_url(@customer_project), notice: "Customer project was successfully created." }
        format.json { render :show, status: :created, location: @customer_project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_projects/1 or /customer_projects/1.json
  def update
    respond_to do |format|
      if @customer_project.update(customer_project_params)
        format.html { redirect_to customer_project_url(@customer_project), notice: "Customer project was successfully updated." }
        format.json { render :show, status: :ok, location: @customer_project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_projects/1 or /customer_projects/1.json
  def destroy
    @customer_project.destroy

    respond_to do |format|
      format.html { redirect_to customer_projects_url, notice: "Customer project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_project
      @customer_project = CustomerProject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_project_params
      params.require(:customer_project).permit(:name, :project_id)
    end
end
