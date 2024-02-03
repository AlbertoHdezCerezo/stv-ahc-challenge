class Listing < ApplicationRecord
  validates :title, :start_time, :end_time, presence: true
  validate :end_time_is_later_than_start_time

  private
    def end_time_is_later_than_start_time
      if end_time? && start_time? && end_time < start_time
        errors.add(:end_time, 'should be later than :start_time')
      end
    end
end
