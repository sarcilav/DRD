require 'drb'

class ChatClient

  @user_id
  @message

  def recv_messages message
    puts "#{Time.now} #{message}"
  end

  attr_accessor :user_id
end

DRb.start_service nil, ChatClient.new
server = DRbObject.new nil, ARGV.shift
puts "Alias:"
user_id = STDIN.gets.chomp
puts "Escriba logout para terminar la sesion"
puts "Start Chatting"
server.login user_id, DRb.uri

while message = STDIN.gets.chomp 
  server.send_message user_id, message

  if message == "logout"
    break
  end

end
DRb.stop_service
