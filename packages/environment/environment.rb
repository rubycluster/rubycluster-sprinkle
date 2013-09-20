package :environment do

  description 'Environment'

  requires_each(%w[
    time
    apt_get_update
    build_essential
    tools
  ])

end
