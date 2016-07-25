require 'spec_helper'

describe Gophr do
  context 'configuration' do
    context 'api_url' do
      let(:dummy_url) { 'http://new.dummy_url.com' }

      it 'has api_url configurable' do
        expect { described_class.api_url = dummy_url }.to change { described_class.api_url }.from(nil).to(dummy_url)
      end
    end

    context 'api_key' do
      let(:dummy_url) { 'sand-123abc-000-abc-111-zzz' }

      it 'has api_key configurable' do
        expect { described_class.api_key = dummy_url }.to change { described_class.api_key }.from(nil).to(dummy_url)
      end
    end
  end

  context 'version' do
    it 'is 1.0.0' do
      expect(described_class::VERSION).to eq('1.0.0')
    end
  end
end
