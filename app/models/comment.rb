class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :creator, class_name: "User"
end
