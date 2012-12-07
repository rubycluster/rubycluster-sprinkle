package :environment do

  description 'Environment'

  requires_each(%w[
    time
    apt_get_update
    locale_rus
    build_essential
    tools
  ])

end
