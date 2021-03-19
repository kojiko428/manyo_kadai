class ApplicationRecord < ActiveRecord::Base
  # protect_from_forgery with: :exception
  self.abstract_class = true
end
