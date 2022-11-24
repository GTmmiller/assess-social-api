class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :desc_limit, -> (limit) { order(id: :desc).limit(limit) }
  scope :paginate_and_limit, -> (last_id, limit) { where("id < ?", last_id).order(id: :desc).limit(limit) }
end
