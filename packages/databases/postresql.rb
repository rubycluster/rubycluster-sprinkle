package :postgresql, :provides => :database do

  apt %w(postgresql postgresql-client libpq-dev)

  verify do
    has_executable 'psql'
  end

end
