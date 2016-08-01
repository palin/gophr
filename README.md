# GOPHR

A wrapper for GOPHR Commercial API (https://developers.gophr.com/)

### Installation

Add to your Gemfile
```ruby
gem 'gophr'
```

Run 
```
bundle install
```

---

### Set API url and key
 
  You can do it in a separate initializer file or just before any Gophr code. You probably want to use sandbox url and key in your development environment. Don't store your production api key in the source code. Save it in your server's environment variable.

```ruby
Gophr.api_url = HERE_GOES_GOPHR_API_URL
Gophr.api_key = HERE_GOES_YOUR_OWN_GOPHR_API_KEY
```

---

### Create a job - `create`
    
This is the basic code which allows you creating a new GOPHR job.

```ruby
job = Gophr::Job.new(hash_with_new_job_details)
job.create
```

Usage example:

```ruby
job = Gophr::Job.new(
  pickup_address1: 'My Super Pickup Street 123',
  pickup_country_code: 'GB',
  pickup_email: 'test-email@testemails.com',
  delivery_address1: 'My Delivery Street 098',
  is_food: 1,
  earliest_pickup_time: '2016-01-31T09:15:00+1:00',
  delivery_deadline: 2016-01-31T13:45:00+1:00,
  callback_url: 'http://my.application.com/gophr/callback'
)
job.create
```
  
Last line `job.create` will call GOPHR API and if everything's fine, you will get a `Gophr::Job` instance with attributes and `job_id` in return.

---

### Update a job - `update({...})`

If you have a job created already, you can update its details.
You don't have to call `job.create`. This is only if the job doesn't exist on GOPHR servers yet. If the job exists there, you can pass its `job_id` as a constructor's last argument.

```ruby
  job = Gophr::Job.new(...)
  job.create
  ...
  job.update(hash_of_properties_you_want_to_update)
```

OR

```ruby
  job = Gophr::Job.new({}, job_id)
  job.update(hash_of_properties_you_want_to_update)
```

Usage example:

```ruby
  job.update(
    pickup_address1: 'My New Super Street 321', 
    is_food: 0, 
    pickup_country_code: "US"
  )
```

`job.update(...)` will call GOPHR API and update a job by its `job_id`. If no error occurs, you will get an updated `Gophr::Job` instance.

---

### Confirm a job - `confirm!`

After creating a job you have to confirm it to make it 'real'. 

```ruby
  job = Gophr::Job.new(...)
  job.create
  ...
  job.confirm!
```

OR

```ruby
  job = Gophr::Job.new({}, job_id)
  job.confirm!
```

In response you will get a `Gophr::Job` instance with some new attributes returned by GOPHR API.

---

### Get a job's cancelation cost - `cancelation_cost`

After creating a job you can cancel it (it's not necessary) for free, but if you confirm it, you will most likely pay for it. This method returns the cost of cancelation the job.

```ruby
job = Gophr::Job.new(...)
...
job.cancelation_cost
```

The `job.cancelation_cost` will call GOPHR API and return a value.

---

### Cancel a job - `cancel!`
  
After creating or confirming a job you can cancel it.

```ruby
job = Gophr::Job.new(...)
...
job.cancel!
```

The `job.cancel!` will call GOPHR API and return boolean `true` if cancelation succeeded.

---

### Simulate a callback - `simulate_callback`

After confirming a job you can simulate a callback to check if your code works properly (you have to pass `callback_url` in job's attributes). Your `callback_url` has to be publicly visible over Internet, it can't be a localhost url because it goes through GOPHR API and it's called from there.

```ruby
job = Gophr::Job.new(...)
...
job.simulate_callback
```

Usage example:
```ruby
job = Gophr::Job.new(...)
job.simulate_callback( 
  status: 'ACCEPTED_BY_COURIER', 
  progress: 45
)
```

In return you will get a hash with parameters and your own API key to validate authenticity.
