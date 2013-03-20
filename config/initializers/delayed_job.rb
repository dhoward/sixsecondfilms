Delayed::Worker.max_run_time = 24.hours
Delayed::Worker.delay_jobs = !Rails.env.development?