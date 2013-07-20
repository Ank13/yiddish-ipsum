# ensure port set
export PORT=${PORT-4000}
# start the server in the right gem environment
exec bundle exec ruby server.rb -p $PORT
