# frozen_string_literal: true

RSpec.describe Event, type: :model do
  let(:event) { Event.new(title: 'Some title', start_on: Date.parse('2018-06-16'), end_on: Date.parse('2018-06-22')) }
  let(:invalid_dates_event) do
    Event.new(title: 'Some title', start_on: Date.parse('2018-06-22'), end_on: Date.parse('2018-06-16'))
  end
  let(:invalid_event) { Event.new }
  let(:cant_be_blank) { I18n.t('errors.messages.blank') }
  let(:end_before_start) { I18n.t('errors.messages.end_before_start') }

  context 'with validation' do
    describe 'blank attributes' do
      before { invalid_event.valid? }

      it { expect(invalid_event.errors[:title]).to include cant_be_blank }
      it { expect(invalid_event.errors[:start_on]).to include cant_be_blank }
      it { expect(invalid_event.errors[:end_on]).to include cant_be_blank }
    end

    describe 'end date before start date' do
      before { invalid_dates_event.valid? }

      it { expect(invalid_dates_event.errors[:end_on]).to include end_before_start }
    end

    describe 'valid attributes' do
      before { event.valid? }

      it { expect(event.errors.any?).to be_falsey }
    end
  end
end
