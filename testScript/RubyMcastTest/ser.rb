=begin
  Send IGMP join/membership pkt and wait for ms, then thread exit
  by xiaoyang 03Dec13
=end

require 'socket'
require 'ipaddr'
require 'yaml'

# read config
config = YAML::load(File.open('config.yaml'))
PORT = config["igmp"]["port_start"]
TEST_CASE_CNT = config["igmp"]["max_sock"]

sThreads = []

# mcast_addr 224.1.0.1~224.1.1.127
(0..TEST_CASE_CNT).each do |n|
	mcast_addr = "224.1.1.#{n}"
	port = PORT + n

	ip = IPAddr.new(mcast_addr).hton + IPAddr.new("0.0.0.0").hton
	sock = UDPSocket.new
	sock.setsockopt(Socket::IPPROTO_IP, Socket::IP_ADD_MEMBERSHIP,ip)
	sock.bind(Socket::INADDR_ANY, port)

	sThreads[n] = Thread.start do
		p "thread #{n} #{sThreads[n]} send igmp membership then waiting."
		# recv two messages then join thread
		msg,info = sock.recvfrom(1024)
		puts "MSG: #{msg} from #{info[2]} (#{info[3]}/#{info[1]}/size:#{msg.size})"
	end

	sleep 0.5
end

sThreads.each do |t|
	p "thread #{t} join."
	t.join
end
