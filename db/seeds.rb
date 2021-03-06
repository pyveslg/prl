# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


batch = [551]

batch.each do |b|
  puts "------> Creating alumni for batch #{b}…"
  GetAlumniJob.perform_now(b)
end

User.find_each do |u|
  puts "------> Creating repositories for #{u.full_name}…"
  CreateRepositoriesJob.perform_now(u)
end

Repository.find_each do |r|
  puts "------> Creating commits for #{r.full_name}…"
  CreateCommitsJob.perform_now(r)
end
