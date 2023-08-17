class AddWorkflowToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :workflow, :text

    reversible do |dir|
      dir.up do
        Project.all.each do |p|
          p.workflow = {
            states: {
              new: {
                initial: true,
                transitions: {
                  in_progress: {}
                }
              },
              in_progress: {
                transitions: {
                  blocked: {},
                  done: {},
                }
              },
              blocked: {
                transitions: {
                  in_progress: {},
                  done: {},
                }
              },
              done: {}
            }
          }
          p.save!
        end
      end
    end
  end
end