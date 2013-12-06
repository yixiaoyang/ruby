require 'socket'
require 'ipaddr'
require 'yaml'

# read config
config = YAML::load(File.open('config.yaml'))
PORT = config["igmp"]["port_start"]
TEST_CASE_CNT = config["igmp"]["max_sock"]
PKT_CNT = config["mcast_sender"]["cnt"]

#TEST_CASE_CNT = 4
# mcast_addr 224.1.0.1~224.1.1.127
(0..TEST_CASE_CNT).each do |n|
  mcast_addr = "224.1.1.#{n}"
  port = 9000

  begin
    sock = UDPSocket.open
    sock.setsockopt(Socket::IPPROTO_IP, Socket::IP_TTL,[20].pack('i'))
    p "send igmp msg count #{n} on port #{port}"
    sock.send( "Hello gentle readers",0, mcast_addr, port)
  ensure
    sock.close
  end
end
