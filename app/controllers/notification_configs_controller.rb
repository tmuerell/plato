class NotificationConfigsController < ApplicationController
  load_and_authorize_resource

  # GET /notification_configs or /notification_configs.json
  def index
  end

  # GET /notification_configs/1 or /notification_configs/1.json
  def show
  end

  # GET /notification_configs/new
  def new
    @notification_config = NotificationConfig.new
  end

  # GET /notification_configs/1/edit
  def edit
  end

  # POST /notification_configs or /notification_configs.json
  def create
    @notification_config = NotificationConfig.new(notification_config_params)

    respond_to do |format|
      if @notification_config.save
        format.html { redirect_to notification_config_url(@notification_config), notice: "Notification config was successfully created." }
        format.json { render :show, status: :created, location: @notification_config }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @notification_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notification_configs/1 or /notification_configs/1.json
  def update
    respond_to do |format|
      if @notification_config.update(notification_config_params)
        format.html { redirect_to notification_config_url(@notification_config), notice: "Notification config was successfully updated." }
        format.json { render :show, status: :ok, location: @notification_config }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notification_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notification_configs/1 or /notification_configs/1.json
  def destroy
    @notification_config.destroy

    respond_to do |format|
      format.html { redirect_to notification_configs_url, notice: "Notification config was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification_config
      @notification_config = NotificationConfig.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notification_config_params
      params.fetch(:notification_config, {}).permit(:delivery_type, :project_id, :filter, :email_recepient_to, :email_recepient_bcc,
                                                    :email_subject, :pager_duty_service_key, :zulip_url,
                                                    :zulip_username, :zulip_password, :zulip_stream, :zulip_topic)
    end
end
