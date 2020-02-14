Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 60
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 5.minutes
Delayed::Worker.read_ahead = 5
Delayed::Worker.default_queue_name = 'default'
Delayed::Worker.delay_jobs = !(Rails.env.test? || Rails.env.development? || Admin::Settings['DELAY_JOBS'] != 'true') # si es test o development que los jobs se ejecuten real time (no en delayed job)
# (lo comento porque no lo entiendo) Delayed::Worker.raise_signal_exceptions = :term
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))