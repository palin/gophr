require 'spec_helper'

describe Gophr::Job do
  describe '#new' do
    let(:attributes) { { pickup_city: 'London', delivery_city: 'Newcastle' } }
    let(:job_id) { '20160725-143836-651941f9093abb0d' }

    context 'without attributes and job_id' do
      let(:job) { described_class.new }

      it 'is an instance of described class' do
        expect(job).to be_kind_of(described_class)
      end
    end

    context 'with attributes only' do
      let(:job) { described_class.new(attributes) }

      it 'has attributes' do
        expect(job.attributes).to eq(attributes)
      end
    end

    context 'with job_id only' do
      let(:job) { described_class.new({}, job_id) }

      it 'has job_id' do
        expect(job.job_id).to eq(job_id)
      end
    end

    context 'with attributes and job_id' do
      let(:job) { described_class.new(attributes, job_id) }

      it 'has attributes' do
        expect(job.attributes).to eq(attributes)
      end

      it 'has job_id' do
        expect(job.job_id).to eq(job_id)
      end
    end
  end

  describe '#create' do
    let(:attributes) { {} }
    let(:job) { described_class.new(attributes) }

    before do
      allow(HTTParty).to receive(:post).and_return(create)
    end

    context 'without errors' do
      let(:create) { double(code: 200, parsed_response: { 'success' => true, 'data' => { 'private_job_url' => 'http://any.url_here.com' }}) }

      it 'changes the job instance' do
        expect { job.create }.to change { job.private_job_url }
      end
    end

    context 'with http error' do
      let(:create) { double(code: 404) }

      it 'returns an http error instance' do
        expect(job.create).to be_kind_of(Gophr::HTTPError)
      end
    end

    context 'with api error' do
      let(:create) { double(code: 200, parsed_response: { 'success' => false }) }

      it 'returns an api error instance' do
        expect(job.create).to be_kind_of(Gophr::APIError)
      end
    end
  end

  describe '#update' do
    let(:attributes) { { delivery_company_name: 'NAME' } }
    let(:new_attributes) { { delivery_company_name: 'NEW_NAME' } }
    let(:job_id) { 'job-0123456789-abc' }
    let(:job) { described_class.new(attributes, job_id) }

    before do
      allow(HTTParty).to receive(:post).and_return(update)
    end

    context 'without errors' do
      let(:update) { double(code: 200, parsed_response: { 'success' => true, 'data' => {}}) }

      it 'changes the job instance' do
        expect { job.update(new_attributes) }.to change { job.delivery_company_name }.from('NAME').to('NEW_NAME')
      end
    end

    context 'with http error' do
      let(:update) { double(code: 404) }

      it 'returns an http error instance' do
        expect(job.update(new_attributes)).to be_kind_of(Gophr::HTTPError)
      end
    end

    context 'with api error' do
      let(:update) { double(code: 200, parsed_response: { 'success' => false }) }

      it 'returns an api error instance' do
        expect(job.update(new_attributes)).to be_kind_of(Gophr::APIError)
      end
    end
  end

  describe '#confirm!' do
    let(:attributes) { {} }
    let(:job) { described_class.new(attributes) }

    before do
      allow(HTTParty).to receive(:post).and_return(confirm)
    end

    context 'without errors' do
      let(:confirm) { double(code: 200, parsed_response: { 'success' => true, 'data' => { 'private_job_url' => 'http://any.url_here.com' }}) }

      it 'changes the job instance' do
        expect { job.confirm! }.to change { job.private_job_url }
      end
    end

    context 'with http error' do
      let(:confirm) { double(code: 404) }

      it 'returns an http error instance' do
        expect(job.confirm!).to be_kind_of(Gophr::HTTPError)
      end
    end

    context 'with api error' do
      let(:confirm) { double(code: 200, parsed_response: { 'success' => false }) }

      it 'returns an api error instance' do
        expect(job.confirm!).to be_kind_of(Gophr::APIError)
      end
    end
  end

  describe '#cancel!' do
    let(:attributes) { {} }
    let(:job) { described_class.new(attributes) }

    before do
      allow(HTTParty).to receive(:post).and_return(cancel)
    end

    context 'without errors' do
      let(:cancel) { double(code: 200, parsed_response: { 'success' => true }) }

      it 'is true' do
        expect(job.cancel!).to eq(true)
      end
    end

    context 'with http error' do
      let(:cancel) { double(code: 404) }

      it 'returns an http error instance' do
        expect(job.cancel!).to be_kind_of(Gophr::HTTPError)
      end
    end

    context 'with api error' do
      let(:cancel) { double(code: 200, parsed_response: { 'success' => false }) }

      it 'returns an api error instance' do
        expect(job.cancel!).to be_kind_of(Gophr::APIError)
      end
    end
  end

  describe '#cancelation_cost' do
    let(:attributes) { {} }
    let(:job) { described_class.new(attributes) }

    before do
      allow(HTTParty).to receive(:post).and_return(cancelation_cost)
    end

    context 'without errors' do
      let(:cancelation_cost) { double(code: 200, parsed_response: { 'success' => true, 'data' => { 'cancelation_cost' => 10.0 } }) }

      it 'is true' do
        expect(job.cancelation_cost).to eq(10.0)
      end
    end

    context 'with http error' do
      let(:cancelation_cost) { double(code: 404) }

      it 'returns an http error instance' do
        expect(job.cancelation_cost).to be_kind_of(Gophr::HTTPError)
      end
    end

    context 'with api error' do
      let(:cancelation_cost) { double(code: 200, parsed_response: { 'success' => false }) }

      it 'returns an api error instance' do
        expect(job.cancelation_cost).to be_kind_of(Gophr::APIError)
      end
    end
  end

  describe '#simulate_callback' do
    let(:attributes) { {} }
    let(:job) { described_class.new(attributes) }

    before do
      allow(HTTParty).to receive(:post).and_return(simulate_callback)
    end

    context 'without errors' do
      let(:simulate_callback) { double(code: 200, parsed_response: { 'success' => true, 'data' => {} }) }

      it 'is returns a hash' do
        expect(job.simulate_callback).to eq({ 'success' => true, 'data' => {} })
      end
    end

    context 'with http error' do
      let(:simulate_callback) { double(code: 404) }

      it 'returns an http error instance' do
        expect(job.simulate_callback).to be_kind_of(Gophr::HTTPError)
      end
    end

    context 'with api error' do
      let(:simulate_callback) { double(code: 200, parsed_response: { 'success' => false }) }

      it 'returns an api error instance' do
        expect(job.simulate_callback).to be_kind_of(Gophr::APIError)
      end
    end
  end
end
