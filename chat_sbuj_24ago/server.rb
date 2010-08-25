require 'drb'

class ChatServer

  def initialize
    @users = {}
  end
  
  def login user_id, user_url
    @users[user_id] = user_url
  end
  
  def logout user_id
    users.reject! {|key, value| key == user_id } 
  end
  
  def send_message user_id, message
    puts "#{user_id} #{message}"
    if message == "logout"
      newmessage = "**#{user_id} Sale del chat**"
    elsif
      newmessage =  "#{user_id}: #{message}"
    end
    @users.each_pair  do | uid, uurl |
     client = DRbObject.new( nil, uurl).recv_messages( newmessage ) unless uid == user_id
    end 
  end

  attr_accessor :users
end

DRb.start_service nil, ChatServer.new
puts DRb.uri
DRb.thread.join
