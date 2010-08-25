require 'drb'
require 'yaml'
class ChatServer
  attr_accessor :users, :active_users, :id
  def initialize
    @users = {}
    @active_users = {}
    @id = 1
  end
  def register(user)
    status = -1
    if @users[user].nil?
      @users[user] = @id
      @id += 1
      return status = @users[user]
    end
    status
  end
  def login(user,uri)
    puts "#{user} login"
    if @active_users[user].nil?
      @active_users[user] = uri
      return @users[user]
    else
      return -1
    end
  end
  def logout(user)
    @active_users.reject! { | key, value | key == user }
  end
  def send_message(user,message)
    puts "#{user} send msg"
    msg = "#{user}: #{message}\tat #{Time.now}"
    @active_users.each_pair do |uid, uri|
      if uid != user
        client = DRbObject.new nil, uri
        client.recv_messages(msg)
      end
    end
  end
end
server_config = YAML.load_file( File.join(File.dirname(__FILE__),"/" , "server.yml" ))
uri = "druby://#{server_config['url']}:#{server_config['port']}"
DRb.start_service uri, ChatServer.new
puts DRb.uri

DRb.thread.join
