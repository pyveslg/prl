class BatchesController < ApplicationController
  def new
    @batch = Batch.new
  end

  def create
    batch = Batch.new(**batch_params.to_h.symbolize_keys)
    GetAlumniJob.perform_now(batch.number)
    batch.repository_urls.each_with_index do |url, index|
      sleep 1 unless index == 0
      repository = Repository.matching_github_url(url).first_or_create!(batch: batch.number)
      CreateCommitsJob.perform_later(repository)
    end
    redirect_to scopes_path(:top, batch: batch.number)
  end

  private

  def batch_params
    params.require(:batch).permit(:number, :repository_urls)
  end
end
