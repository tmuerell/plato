class RemoveCustomerProjects < ActiveRecord::Migration[7.0]
  def change
    #remove_column :projects, :customer_project_id
    remove_column :tickets, :customer_project_id

    drop_table :customer_projects
  end
end
