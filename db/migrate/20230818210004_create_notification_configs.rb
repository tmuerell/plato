class CreateNotificationConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_configs do |t|
      t.string :delivery_type
      t.references :project, null: false, foreign_key: true
      t.string :filter

      t.string :email_recepient_to, null: true
      t.string :email_recepient_bcc, null: true
      t.string :email_subject, null: true

      t.string :pager_duty_service_key, null: true

      t.string :zulip_url, null: true
      t.string :zulip_username, null: true
      t.string :zulip_password, null: true
      t.string :zulip_stream, null: true
      t.string :zulip_topic, null: true

      t.timestamps
    end
  end
end
