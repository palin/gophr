require 'spec_helper'

describe Gophr::Error do
  context 'Error' do
    let(:error_message) { 'Something went wrong...' }
    let(:gophr_error) { described_class.new(error_message) }

    it 'has a response attribute' do
      expect(gophr_error.response).to eq(error_message)
    end
  end
end
