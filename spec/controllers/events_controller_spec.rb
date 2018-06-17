# frozen_string_literal: true

RSpec.describe EventsController, type: :controller do
  context 'with responds to' do
    describe 'GET /events' do
      before { get :index }

      it { expect(response.content_type).to eq 'text/html' }
      it { expect(response).to render_template(:index) }
    end

    describe 'POST /events' do
      describe 'success' do
        before do
          post :create,
               params: { event: { title: 'Event title', start_on: Date.today, end_on: 1.day.from_now } }, xhr: true
        end

        it { expect(response.content_type).to eq 'text/javascript' }
        it { expect(response).to render_template(:create) }
      end

      describe 'fail' do
        # without Title
        before { post :create, params: { event: { start_on: Date.today, end_on: 1.day.from_now } }, xhr: true }

        it { expect(response.content_type).to eq 'text/javascript' }
        it { expect(response).to render_template(:fail_form) }
      end
    end
  end
end
