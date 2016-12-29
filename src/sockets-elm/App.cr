require "kemal"

SOCKETS = [] of HTTP::WebSocket

get "/" do
  "Welcome To Kemal, everything is ok"
end

ws "/chat" do |socket|
  SOCKETS << socket

  socket.on_message do |message|
    SOCKETS.each { |socket| socket.send message }
  end

  socket.on_close do |socket|
    SOCKETS.delete socket
  end
end

Kemal.run
