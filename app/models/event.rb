class Event < ApplicationRecord
  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :volunteers
end
