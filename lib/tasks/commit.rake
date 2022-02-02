namespace :commit do
  desc "Delete old commits with null or negative scores"
  task delete_old: :environment do
    CleanOldCommitsJob.perform_now
  end
end
