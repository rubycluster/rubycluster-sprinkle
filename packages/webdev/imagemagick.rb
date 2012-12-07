package :imagemagick do

  description "Image Magick"

  apt 'imagemagick librmagick-ruby'

  verify do
    has_executable "convert"
  end

end
