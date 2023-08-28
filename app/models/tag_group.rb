class TagGroup < ApplicationRecord
  has_many :tags
  belongs_to :project

  APPROVAL_NAME = 'Approval'.freeze
  APPROVAL_DEFAULT_TAG_NAMES = %w[NeedsApproval].freeze

  AREA_NAME = 'Area'.freeze

  BOARD_NAME = 'Board'.freeze

  SEVERITY_NAME = 'Severity'.freeze
  SEVERITY_DEFAULT_TAG_NAMES = %w[Critical Major Minor].freeze

  NAMES = [APPROVAL_NAME, AREA_NAME, BOARD_NAME, SEVERITY_NAME].freeze
end
