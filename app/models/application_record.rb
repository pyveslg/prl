class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :by_random, -> { reorder(Arel.sql("RANDOM()")) }
end
