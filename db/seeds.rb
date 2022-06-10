# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

repositories_by_batch = {
  # 551 => %w[
  #   https://github.com/luciecam/collection-app
  #   https://github.com/soufianejebbari/PYC
  #   https://github.com/troptropcontent/yummi
  #   https://github.com/grambetta/game-aware
  #   https://github.com/laurecdp/carefree
  #   https://github.com/AlexandraCF/park_easy
  #   https://github.com/jayk-u/phasing
  # ],
  # 591 => %w[
  #   https://github.com/nicolasdubet/FEELER
  #   https://github.com/Lenjy/un_pas_pour_les_autres
  #   https://github.com/CeliaTrache/SoundOn
  #   https://github.com/ChenchenZheng/le-plateau
  #   https://github.com/sugarsheet/book_society
  # ],
  # 660 => %w[
  #   https://github.com/Tiebow/MATCH_POINT
  #   https://github.com/anietchka/kids-out
  #   https://github.com/Anne-crypt/PACMAN-GO
  #   https://github.com/Ztrub19/SwipArt
  #   https://github.com/1maaat/rocketly
  #   https://github.com/BeneNolte/jicama
  #   https://github.com/Andrea-ellii/ellii
  #   https://github.com/quentin-peschard/drug_dealer
  #   https://github.com/mar7ius/simple-trip-me
  #   https://github.com/OrnellaBis/Surf_Go
  #   https://github.com/ricawdo/air_cut
  # ],
  # 730 => %w[
  #   https://github.com/JadeCathleen/my-batch-cooker
  #   https://github.com/sophieguiller/secret-alien
  #   https://github.com/Arti2666/Shotgunz
  #   https://github.com/VictorChomette/sports_connect
  #   https://github.com/kevinkotcherga/VIBES
  #   https://github.com/sixtine-c/perfect_watch
  #   https://github.com/infotestmax/memory-squared
  #   https://github.com/RaniaB16/DRUNKED
  #   https://github.com/Frizilborld/uniqueness
  #   https://github.com/Tompagpag/Family_schedule
  # ],
  # 731 => %w[
  #   https://github.com/Delphine-cph/tocare
  #   https://github.com/steppan26/myra
  #   https://github.com/Charlotte-smets/rails-artmeets
  #   https://github.com/yasmine-glitch/STORK
  #   https://github.com/margliard/slowtravel
  #   https://github.com/Vigrouze/freementors
  #   https://github.com/tdeganay/dcrypt
  #   https://github.com/JulienMalcouronne/FestivOut
  # ],

  # 800 => %w[
  #   https://github.com/Pist4ch30/SplitHouse
  #   https://github.com/Zizanie911/neatter
  #   https://github.com/Maxplasse/foodclass
  #   https://github.com/Mattfl22/GETYOSHARES
  #   https://github.com/Arndau/rails-poner
  #   https://github.com/K-Fabey/billr
  #   https://github.com/max212118/wastrack
  #   https://github.com/TomVsn/Momento-batch-800
  #   https://github.com/anjacquemin/rails_explora_world
  # ],

  # 801 => %w[
  #   https://github.com/Djoul75/MELOV
  #   https://github.com/clementgateaud/whispers
  #   https://github.com/nicolasollier/peertopair
  #   https://github.com/ThierryFqn/contribute
  #   https://github.com/caroline-dana/skilly
  #   https://github.com/leobufi/elisee
  #   https://github.com/rigardm/balmoral
  # ],
  861 => %w[
    https://github.com/Warhadzaaa/intermittent
    https://github.com/batleclair/tomorrow-works
    https://github.com/Charralle/FIT
    https://github.com/Mamsoc/BeMyBest
    https://github.com/atchee/RPUW
    https://github.com/Newprotagonist/Gaming_Next
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
  GetAlumniJob.perform_later(b)
end

repositories_by_batch.values.flatten.each do |repository_url|
  repository = Repository.matching_github_url(repository_url).first
  puts "------> Creating commits for #{repository.full_name}…"
  CreateCommitsJob.perform_later(repository)
end
