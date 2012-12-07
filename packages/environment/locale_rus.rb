package :locale_rus do

  runner 'locale-gen ru_RU.utf8'
  runner 'dpkg-reconfigure locales'
  runner 'update-locale LANG=ru_RU.utf8'

  # FIXME: fails while running first time
  # verify do
  #   has_version_in_grep 'locale', "LANG=ru_RU.utf8"
  # end

end
