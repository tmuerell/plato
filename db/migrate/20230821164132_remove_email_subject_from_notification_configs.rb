class RemoveEmailSubjectFromNotificationConfigs < ActiveRecord::Migration[7.0]
  def change
    remove_column :notification_configs, :email_subject, :text
  end
end
