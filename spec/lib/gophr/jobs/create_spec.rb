require 'spec_helper'

describe Gophr::Jobs::Create do
  let(:options) { { external_id: 'any-id' } }
  let(:job) { described_class.new(options) }

  describe '#new' do
    it 'has options assigned' do
      expect(job.options).to eq(options)
    end
  end

  describe '#call' do
    subject { job.call }

    context 'successful call' do
      it 'uses httparty' do
        expect(HTTParty).to receive(:post).with("#{Gophr.api_url}/create-job",
          headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
          body: { api_key: Gophr.api_key, external_id: 'any-id' }
        ).and_return(double(code: 200, parsed_response: { 'success' => true, 'data' => {} }))

        subject
      end
    end
  end
end
