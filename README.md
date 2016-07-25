# gophr

A wrapper for GOPHR Commercial API (https://developers-test.gophr.com/docs)

1. Set API url and key. You can do it in a separate initializer file or just before any Gophr code. You probably want to use sandbox url and key in your development environment. Don't store your production api key in the source code. Save it in your server's environment variable.

  ```
  Gophr.api_url = // HERE GOES GOPHR API URL
  Gophr.api_key = // HERE GOES YOUR OWN GOPHR API KEY
  ```
  
2.Usage:

  1. Create a job - `create`
    
    This is the basic code which allows you creating a new GOPHR job.

    ```
      job = Gophr::Job.new(hash_with_new_job_details)
      job.create
    ```

    Usage example:
    ```
      job = Gophr::Job.new(
        pickup_address1: 'My Super Pickup Street 123'
        pickup_country_code: 'GB'
        pickup_email: 'test-email@testemails.com'
        delivery_address1: 'My Delivery Street 098'
        is_food: 1
        earliest_pickup_time: '2016-01-31T09:15:00+1:00'
        delivery_deadline: 2016-01-31T13:45:00+1:00
        callback_url: 'http://my.application.com/gophr/callback'
      )
      job.create
    ```
    
    Last line `job.create` will call GOPHR api and if everything's fine, you will get a `Gophr::Job` instance with attributes and `job_id` in return.


  2. Update a job - `update({...})`
  
    If you have a job created already, you can update its details.
    You don't have to call `job.create`. This is only if the job doesn't exist on GOPHR servers yet. If the job exists there, you can pass its `job_id` as a constructor's last argument.

    ```
      job = Gophr::Job.new(...)
      job.create
      ...
      job.update(hash_of_properties_you_want_to_update)
    ```

    OR

    ```
      job = Gophr::Job.new({...}, job_id)
      job.update(hash_of_properties_you_want_to_update)
    ```

    Usage example:
    ```
      job.update(
        pickup_address1: 'My New Super Street 321', 
        is_food: 0, 
        pickup_country_code: "US"
      )
    ```

    `job.update(...)` will call GOPHR API and update a job by its `job_id`. If no error occurs, you will get an updated `Gophr::Job` instance.

  3. Confirm a job - `confirm!`

    After creating a job you have to confirm it to make it 'real'. 

    ```
      job = Gophr::Job.new(...)
      job.create
      ...
      job.confirm!
    ```

    OR

    ```
      job = Gophr::Job.new(job_id)
      job.confirm!
    ```
    
    In response you will get a `Gophr::Job` instance with some new attributes returned by GOPHR api.

  4. Get a job's cancelation cost - `cancelation_cost`
  
    After creating a job you can cancel it (it's not necessary) for free, but if you confirm it, you will most likely pay for it. This method returns the cost of cancelation the job.

    ```
    job = Gophr::Job.new(...)
    ...
    job.cancelation_cost
    ```

    The `job.cancelation_cost` will call GOPHR API and return a value.

  5. Cancel a job - `cancel!`
    
    After creating or confirming a job you can cancel it.

    ```
    job = Gophr::Job.new(...)
    ...
    job.cancel!
    ```

    The `job.cancel!` will call GOPHR API and return boolean `true` if cancelation succeeded.

  6. Simulate a callback - `simulate_callback`

    After confirming a job you can simulate a callback to check if your code works properly. Your `callback_url` has to be publicly visible over Internet, it can't be a localhost url because it goes through GOPHR API.

    ```
    job = Gophr::Job.new(...)
    ...
    job.simulate_callback(callback_url, options)
    ```

    Usage example:
    ```
    job = Gophr::Job.new(...)
    job.simulate_callback('http://my.application.com/gophr/callback', status: 'ACCEPTED_BY_COURIER', progress: 45)
    ```

    In return you will get a hash with parameters and your api_key to validate authenticity.
