package :sqlite3, :provides => :database do

  apt %w(
    sqlite3
    libsqlite3-0 libsqlite3-dev
  )

  verify do
    has_executable 'sqlite3'
  end

end
