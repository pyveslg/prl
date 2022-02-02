namespace :commit do
  desc "Delete old commits with null or negative scores"
  task delete_old: :environment do
    CleanOldCommitsJob.perform_now
  end

  desc "Delete useless commits (automatic...)"
  task delete_useless: :environment do
    CleanUselessCommitsJob.perform_now
  end
end
