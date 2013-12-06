=begin
  Send IGMP message via socket
  by xiaoyang 03Dec13
=end
require 'socket'
require 'ipaddr'
require 'yaml'

# read config
config = YAML::load(File.open('config.yaml'))
PORT = config["igmp"]["port_start"]
TEST_CASE_CNT = config["igmp"]["max_sock"]

# mcast_addr 224.1.0.1~224.1.1.127
(0..TEST_CASE_CNT).each do |n|
	mcast_addr = "224.1.1.#{n}"
	port = PORT + n
	
	sock = UDPSocket.open
	sock.setsockopt(Socket::IPPROTO_IP, Socket::IP_TTL, [1].pack('i'))
	
	# send out msg 
	p "send igmp msg count #{n} on port #{port}"
	sock.send(ARGV.join(' '),0, mcast_addr, port)
	
	begin
	ensure
		sock.close
	end
end
