class CreateCustomerProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_projects do |t|
      t.string :name

      t.timestamps
    end
  end
end
