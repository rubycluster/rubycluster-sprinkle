# Monkey patch...

module Sprinkle

  class Settings

    @@capistrano = {}

    def self.set_variables=(set)
      @@capistrano = set
    end

    def self.fetch(name)
      @@capistrano[name]
    end

    def self.exists?(name)
      @@capistrano.key?(name)
    end

  end

end
