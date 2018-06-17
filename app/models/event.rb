# frozen_string_literal: true

class Event < ApplicationRecord
  validates :title, :start_on, :end_on, presence: true
  validate :end_before_start

  scope :for_week, lambda { |start_of_week|
    where(
      'start_on >= :start_of_week AND start_on <= :end_of_week ',
      start_of_week: start_of_week,
      end_of_week: start_of_week + 6.days
    ).order(start_on: :asc)
  }

  private

  def end_before_start
    return false if end_on.blank? || start_on.blank?
    return true if (end_on > start_on) || (end_on == start_on)
    errors.add(:end_on, I18n.t('errors.messages.end_before_start'))
    false
  end
end
