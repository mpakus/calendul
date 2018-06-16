# frozen_string_literal: true

class Event < ApplicationRecord
  validates :title, :start_on, :end_on, presence: true
  validate :end_before_start

  private

  def end_before_start
    return false if end_on.blank? || start_on.blank?
    return true if end_on > start_on
    errors.add(:end_on, I18n.t('errors.messages.end_before_start'))
    false
  end
end
