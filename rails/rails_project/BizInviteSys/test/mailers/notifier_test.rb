require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "email_user" do
    mail = Notifier.email_user
    assert_equal "Email user", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
