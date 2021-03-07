class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :by_random, -> { order(Arel.sql("RANDOM()")) }
end
