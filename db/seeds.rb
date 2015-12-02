# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

apps = %w(meta-secretary heimdall omorfia jenkins synargus)
created_ats = (1..7).to_a

150.times do
  app = apps.sample
  dep = Deployment.new(
    commit_sha: SecureRandom.uuid,
    tag: 'v0.1.1',
    server: 'production',
    application: app,
    created_at: created_ats.sample.days.ago,
    repository_name: app
  )
  dep.save!
end
