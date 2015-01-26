package :imagemagick do

  description "Image Magick"

  apt 'imagemagick libmagickwand-dev'

  verify do
    has_executable "convert"
  end

end
