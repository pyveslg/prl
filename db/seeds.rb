# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

repositories_by_batch = {
  551 => [
    # "https://github.com/luciecam/collection-app",
    # "https://github.com/soufianejebbari/PYC",
    # "https://github.com/troptropcontent/yummi",
    # "https://github.com/grambetta/game-aware",
    # "https://github.com/laurecdp/carefree",
    # "https://github.com/AlexandraCF/park_easy",
    # "https://github.com/jayk-u/phasing",
  ],
  401 => [
    "https://github.com/alex-eyben/mon_depute"
  ]
}

repositories_by_batch.each do |batch, repositories|
  puts "------> Creating #{repositories.count} repositories for batch #{batch}…"
  repositories.each do |url|
    Repository.matching_github_url(url).first_or_create!(batch: batch)
  end
end

repositories_by_batch.keys.each do |b|
  puts "------> Creating alumni for batch #{b}…"
  GetAlumniJob.perform_now(b)
end

Repository.find_each do |r|
  puts "------> Creating commits for #{r.full_name}…"
  CreateCommitsJob.perform_now(r)
end
