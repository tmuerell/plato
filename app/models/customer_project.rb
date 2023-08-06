class CustomerProject < ApplicationRecord
  has_many :tickets
  belongs_to :project

  validates_presence_of :name
end
