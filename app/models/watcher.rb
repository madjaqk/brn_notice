class Watching < ActiveRecord::Base
  belongs_to :watcher, class_name: "user"
  belongs_to :watched, class_name: "user"
end
