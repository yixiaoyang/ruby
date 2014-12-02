require 'net/smtp'

message = <<MESSAGE_END
From:163 Mailer <hityixiaoyang@163.com>
To: yixaioyangQQMail <729408711@qq.com>
MIME-Version: 1.0
Content-type: text/html
Subject: SMTP e-mail test

This is an e-mail message to be sent in HTML format

<b>This is HTML message.</b>
<h1>This is headline.</h1>
MESSAGE_END

Net::SMTP.start('smtp.163.com',25,'163.com','hityixiaoyang@163.com','daiyiwen',:login) do |smtp|
#Net::SMTP.start('localhost') do |smtp|
     smtp.send_message message, 'hityixiaoyang@163.com', 
		                             '729408711@qq.com'
end

