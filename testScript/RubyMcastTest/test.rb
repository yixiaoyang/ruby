require 'socket'
require 'ipaddr'
require 'yaml'

3.times  {
 p "hello"
 sleep 0.1
}

(1...3).each do |x|
 p x
end

# read config
config = YAML::load(File.open('config.yaml'))
PORT = config["igmp"]["port_start"]
TEST_CASE_CNT = config["igmp"]["max_sock"]
PKT_CNT = config["mcast_sender"]["cnt"]

# mcast_addr 224.1.0.1~224.1.1.127
(0..TEST_CASE_CNT).each do |n|
  mcast_addr = "224.1.1.#{n}"

  # using the diffident port
  port = PORT-1

  begin
    sock = UDPSocket.open
    sock.setsockopt(Socket::IPPROTO_IP, Socket::IP_TTL, [1].pack('i'))
    # send out msg
    p "send igmp msg count #{n} on port #{port}"
    sock.send(ARGV.join(' '),0, mcast_addr, port)
  ensure
    sock.close
  end
end
