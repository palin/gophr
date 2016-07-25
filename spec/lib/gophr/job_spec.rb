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
    let(:job) { described_class.new(attributes) }

    context 'without errors' do
    end

    context 'with http error' do
    end

    context 'with api error' do
    end
  end

  describe '#update' do
  end

  describe '#confirm!' do
  end

  describe '#cancel!' do
  end

  describe '#cancelation_cost' do
  end

  describe '#simulate_callback!' do
  end
end
