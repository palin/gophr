module Gophr
  class Job
    attr_accessor :attributes, :job_id

    def initialize(attributes = {}, job_id = nil)
      @job_id = job_id
      @attributes = attributes
    end

    def get_status
      response = Jobs::GetStatus.new(job_id: job_id).call

      if response.is_a?(Hash)
        assign_attributes(response['data'])
        self
      else
        response
      end
    end

    def create_and_confirm
      response = Jobs::CreateAndConfirm.new(attributes).call

      if response.is_a?(Hash)
        assign_attributes(response['data'])
        self
      else
        response
      end
    end

    def create
      response = Jobs::Create.new(attributes).call

      if response.is_a?(Hash)
        assign_attributes(response['data'])
        self
      else
        response
      end
    end

    def update(new_attributes = {})
      response = Jobs::Update.new(new_attributes.merge!(job_id: job_id)).call

      if response.is_a?(Hash)
        assign_attributes(response['data'].merge!(new_attributes))
        self
      else
        response
      end
    end

    def confirm!
      response = Jobs::Confirm.new(job_id: job_id).call

      if response.is_a?(Hash)
        assign_attributes(response['data'])
        self
      else
        response
      end
    end

    def cancel!
      response = Jobs::Cancel.new(job_id: job_id).call

      if response.is_a?(Hash)
        true
      else
        response
      end
    end

    def cancelation_cost
      response = Jobs::CancelationCost.new(job_id: job_id).call

      if response.is_a?(Hash)
        response['data']['cancelation_cost']
      else
        response
      end
    end

    def simulate_callback
      Jobs::SimulateCallback.new(job_id: job_id).call
    end

    def progress_job
      response = Jobs::ProgressJob.new(job_id: job_id).call

      if response.is_a?(Hash)
        assign_attributes(response['data'])
        self
      else
        response
      end
    end

    [
      :min_realistic_time, :print_label_url, :leg_type, :date_checked_in_1, :date_checked_in_2, :date_picked_up, :date_delivered, :date_finished, :courier_notes, :final_receiver_name,
      :cancellation_reason, :refused_items, :proof_of_delivery, # new fields
      :external_id, :reference_number, :pickup_company_name, :pickup_address1, :pickup_address2, :pickup_city,
      :pickup_postcode, :pickup_country_code, :pickup_tips_how_to_find, :pickup_person_name, :pickup_email,
      :pickup_mobile_number, :pickup_phone_number, :delivery_company_name, :delivery_address1, :delivery_address2,
      :delivery_city, :delivery_postcode, :delivery_country_code, :delivery_tips_how_to_find, :delivery_person_name,
      :delivery_email, :delivery_mobile_number, :delivery_phone_number, :is_food, :is_fragile, :is_liquid,
      :is_not_rotatable, :item_title, :size_x, :size_y, :size_z, :weight, :vehicle_type, :earliest_pickup_time,
      :pickup_deadline, :earliest_delivery_time, :delivery_deadline, :job_priority, :order_value, :insurance_required,
      :callback_url, :private_job_url, :distance, :pickup_eta, :delivery_eta, :price_gross, :price_net,
      :public_tracker_url, :progress, :status, :finished, :courier_name
    ].each do |property|
      define_method(property) { attributes[property] }
      define_method("#{property}=") { |value| attributes[property] = value }
    end

    private

    def assign_attributes(new_attributes = {})
      new_attributes.each do |property, value|
        self.send("#{property}=", value)
      end
    end
  end
end
