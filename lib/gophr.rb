require 'httparty'
require_relative 'gophr/jobs/base.rb'
require_relative 'gophr/jobs/simulate_callback.rb'
require_relative 'gophr/jobs/cancel.rb'
require_relative 'gophr/jobs/cancelation_cost'
require_relative 'gophr/jobs/confirm'
require_relative 'gophr/jobs/create'
require_relative 'gophr/jobs/update'
require_relative 'gophr/error'
require_relative 'gophr/job'

module Gophr
  @api_url = nil
  @api_key = nil

  class << self
    attr_accessor :api_url, :api_key
  end
end
