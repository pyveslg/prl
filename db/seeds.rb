# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

repositories_by_batch = {
  551 => %w[
    https://github.com/luciecam/collection-app
    https://github.com/soufianejebbari/PYC
    https://github.com/troptropcontent/yummi
    https://github.com/grambetta/game-aware
    https://github.com/laurecdp/carefree
    https://github.com/AlexandraCF/park_easy
    https://github.com/jayk-u/phasing
  ],
  591 => %w[
    https://github.com/nicolasdubet/FEELER
    https://github.com/Lenjy/un_pas_pour_les_autres
    https://github.com/CeliaTrache/SoundOn
    https://github.com/ChenchenZheng/le-plateau
    https://github.com/sugarsheet/book_society
  ],
  660 => %w[
    https://github.com/Tiebow/MATCH_POINT
    https://github.com/anietchka/kids-out
    https://github.com/Anne-crypt/PACMAN-GO
    https://github.com/Ztrub19/SwipArt
    https://github.com/1maaat/rocketly
    https://github.com/BeneNolte/jicama
    https://github.com/Andrea-ellii/ellii
    https://github.com/quentin-peschard/drug_dealer
    https://github.com/mar7ius/simple-trip-me
    https://github.com/OrnellaBis/Surf_Go
    https://github.com/ricawdo/air_cut
  ],
  730 => %w[
    https://github.com/JadeCathleen/my-batch-cooker
    https://github.com/sophieguiller/secret-alien
    https://github.com/Arti2666/Shotgunz
    https://github.com/VictorChomette/sports_connect
    https://github.com/kevinkotcherga/VIBES
    https://github.com/sixtine-c/perfect_watch
    https://github.com/infotestmax/memory-squared
    https://github.com/RaniaB16/DRUNKED
    https://github.com/Frizilborld/uniqueness
    https://github.com/Tompagpag/Family_schedule
  ],
  731 => %w[
    https://github.com/Delphine-cph/tocare
    https://github.com/steppan26/myra
    https://github.com/Charlotte-smets/rails-artmeets
    https://github.com/yasmine-glitch/STORK
    https://github.com/margliard/slowtravel
    https://github.com/Vigrouze/freementors
    https://github.com/tdeganay/dcrypt
    https://github.com/JulienMalcouronne/FestivOut
  ],
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
