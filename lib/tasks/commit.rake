namespace :commit do
  desc "Delete old commits with null or negative scores"
  task delete_old: :environment do
    CleanOldCommitsJob.perform_later
  end

  desc "Delete useless commits (merges, common messages…)"
  task delete_useless: :environment do
    CleanUselessCommitsJob.perform_later
  end
end
