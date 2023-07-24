class Tagging < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
end
