class AddProjectNullToCustomerProject < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        #CustomerProject.all.each do |tr|
        #  tr.project = Project.first
        #  tr.save
        #end

        change_column_null :customer_projects, :project_id, false
      end
    end
  end
end
