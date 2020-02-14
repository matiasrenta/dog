class DelayedJobsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :delayed_job_params

  # GET /delayed_jobs
  def index
    @delayed_jobs = indexize(DelayedJob)
  end

  # GET /delayed_jobs/1
  def show
  end

  # DELETE /delayed_jobs/1
  def destroy
    if @delayed_job.destroy
      redirect_to delayed_jobs_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@delayed_job)
      redirect_to :back
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def delayed_job_params
      params.require(:delayed_job).permit(:priority, :attempts, :handler, :last_error, :run_at, :locked_at, :failed_at, :locked_by, :queue)
    end
end
