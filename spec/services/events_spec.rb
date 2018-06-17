# frozen_string_literal: true

RSpec.describe Events do
  let(:monday) { Date.parse('2018-06-11') }
  let(:tue) { Date.parse('2018-06-12') }
  let(:wed) { Date.parse('2018-06-13') }
  let(:thu) { Date.parse('2018-06-14') }
  let(:fri) { Date.parse('2018-06-15') }
  let(:monday_plus) { Date.parse('2018-06-18') }

  let(:events) { described_class.new(Event.for_week(monday)) }
  let(:event1) { Event.create(title: 'Some title1', start_on: monday, end_on: monday) }
  let(:event2) { Event.create(title: 'Some title2', start_on: tue, end_on: wed) }
  let(:event3) { Event.create(title: 'Some title3', start_on: tue, end_on: fri) }
  let(:event4) { Event.create(title: 'Some title4', start_on: monday_plus, end_on: monday_plus + 12.days) }

  let(:events_plus) { described_class.new(Event.for_week(monday_plus)) }

  before do
    # monday
    event1
    # tue wed
    event2
    # tue wed thu fri
    event3
    # next monday+
    event4
  end

  describe '#on' do
    it { expect(events.on(monday)).to include event1 }
    it { expect(events.on(monday)).not_to include event2 }
    it { expect(events.on(monday)).not_to include event3 }
    it { expect(events.on(monday)).not_to include event4 }

    it { expect(events.on(tue)).not_to include event1 }
    it { expect(events.on(tue)).to include event2 }
    it { expect(events.on(tue)).to include event3 }
    it { expect(events.on(tue)).not_to include event4 }

    it { expect(events.on(wed)).not_to include event1 }
    it { expect(events.on(wed)).to include event2 }
    it { expect(events.on(wed)).to include event3 }
    it { expect(events.on(wed)).not_to include event4 }

    it { expect(events.on(thu)).not_to include event1 }
    it { expect(events.on(thu)).not_to include event2 }
    it { expect(events.on(thu)).to include event3 }
    it { expect(events.on(thu)).not_to include event4 }

    it { expect(events.on(fri)).not_to include event1 }
    it { expect(events.on(fri)).not_to include event2 }
    it { expect(events.on(fri)).to include event3 }
    it { expect(events.on(fri)).not_to include event4 }

    it { expect(events_plus.on(monday_plus)).not_to include event1 }
    it { expect(events_plus.on(monday_plus)).not_to include event2 }
    it { expect(events_plus.on(monday_plus)).not_to include event3 }
    it { expect(events_plus.on(monday_plus)).to include event4 }
  end
end
