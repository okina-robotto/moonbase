class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def create_concurrently(attributes)
      create(attributes)
    rescue ActiveRecord::RecordNotUnique
    end
  end
end
