class Tagging < ApplicationRecord
  extend Enumerize

  belongs_to :user, optional: true
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
  belongs_to :user_value, class_name: "User", optional: true

  enumerize :value_type, in: %i[string date user]
end
