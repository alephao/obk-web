class Event < ApplicationRecord
  validate :expiration_date_cannot_be_in_the_past

  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :volunteers

  validates :title, :start_date, :end_date, presence: true

  scope :upcoming, -> { where('start_date >= :start_date', start_date: Time.zone.now).order(start_date: 'desc') }

  def expiration_date_cannot_be_in_the_past
    if start_date.present? && start_date < Time.zone.today
      errors.add(:start_date, "can't be in the past")
    end
  end
end
