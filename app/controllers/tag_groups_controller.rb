class TagGroupsController < ApplicationController
  load_and_authorize_resource

  # GET /tag_groups or /tag_groups.json
  def index
  end

  # GET /tag_groups/1 or /tag_groups/1.json
  def show
  end

  # GET /tag_groups/new
  def new
    @tag_group = TagGroup.new
  end

  # GET /tag_groups/1/edit
  def edit
  end

  # POST /tag_groups or /tag_groups.json
  def create
    @tag_group = TagGroup.new(tag_group_params)

    respond_to do |format|
      if @tag_group.save
        format.html { redirect_to tag_group_url(@tag_group), notice: "Tag group was successfully created." }
        format.json { render :show, status: :created, location: @tag_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tag_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tag_groups/1 or /tag_groups/1.json
  def update
    respond_to do |format|
      if @tag_group.update(tag_group_params)
        format.html { redirect_to tag_group_url(@tag_group), notice: "Tag group was successfully updated." }
        format.json { render :show, status: :ok, location: @tag_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tag_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_groups/1 or /tag_groups/1.json
  def destroy
    @tag_group.destroy

    respond_to do |format|
      format.html { redirect_to tag_groups_url, notice: "Tag group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag_group
      @tag_group = TagGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_group_params
      params.require(:tag_group).permit(:name, :min_count, :max_count)
    end
end
