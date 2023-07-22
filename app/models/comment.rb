class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :ticket
  belongs_to :creator, class_name: "User"

  after_create_commit { broadcast_append_to 'comments' }
end
