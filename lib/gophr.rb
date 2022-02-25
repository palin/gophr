require 'httparty'
require_relative 'gophr/error'
require_relative 'gophr/job'
require_relative 'gophr/jobs/base'
require_relative 'gophr/jobs/cancel'
require_relative 'gophr/jobs/cancelation_cost'
require_relative 'gophr/jobs/confirm'
require_relative 'gophr/jobs/create'
require_relative 'gophr/jobs/create_and_confirm'
require_relative 'gophr/jobs/get_status'
require_relative 'gophr/jobs/simulate_callback'
require_relative 'gophr/jobs/progress_job'
require_relative 'gophr/jobs/update'
require_relative 'gophr/version'

module Gophr
  @api_url = nil
  @api_key = nil

  class << self
    attr_accessor :api_url, :api_key
  end
end
