class Comment < ActiveRecord::Base
  belongs_to :commenter, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :comment, :commenter, :recipient, presence: true
end
