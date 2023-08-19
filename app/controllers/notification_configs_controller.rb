class NotificationConfigsController < ApplicationController
  load_and_authorize_resource

  # GET /notification_configurations or /notification_configurations.json
  def index
  end

  # GET /notification_configurations/1 or /notification_configurations/1.json
  def show
  end

  # GET /notification_configurations/new
  def new
    @notification_config = NotificationConfig.new
  end

  # GET /notification_configurations/1/edit
  def edit
  end

  # POST /notification_configurations or /notification_configurations.json
  def create
    @notification_config = NotificationConfig.new(notification_config_params)

    respond_to do |format|
      if @notification_config.save
        format.html { redirect_to notification_config_url(@notification_config), notice: "NotificationConfig was successfully created." }
        format.json { render :show, status: :created, location: @notification_config }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @notification_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notification_configurations/1 or /notification_configurations/1.json
  def update
    respond_to do |format|
      if @notification_config.update(notification_config_params)
        format.html { redirect_to notification_config_url(@notification_config), notice: "NotificationConfig was successfully updated." }
        format.json { render :show, status: :ok, location: @notification_config }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notification_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notification_configurations/1 or /notification_configurations/1.json
  def destroy
    @notification_config.destroy

    respond_to do |format|
      format.html { redirect_to notification_configurations_url, notice: "NotificationConfig was successfully destroyed." }
      format.json { head :no_content }
    end
  end
end
