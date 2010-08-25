require 'drb'
def help
  puts ".help this message"
  puts ".register <username>"
  puts ".login <username> into the server"
  puts ".logout from server"
end

class ChatClient
  def recv_messages(msg)
    puts msg
  end
end
DRb.start_service nil, ChatClient.new
server = DRbObject.new nil, ARGV.shift
help
user_name = ""
while line = STDIN.gets.chomp
  if line.start_with? ".help"
    help
  elsif line.start_with? ".register"
    if server.register(line.split(" ")[1]) < 0
      puts "user already taken"
      break
    end
    puts "Ok"
  elsif line.start_with? ".login"
    user_name = line.split(" ")[1]
    if server.login(user_name, DRb.uri) < 0
      puts "user already login"
      break
    end
    puts "Starting chat"
  elsif line.start_with? ".logout"
    server.logout(user_name)
    break
  elsif user_name == ""
    puts "No server connection"
  else
    server.send_message(user_name,line)
  end
end


