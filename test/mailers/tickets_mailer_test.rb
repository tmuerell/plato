require "test_helper"

class TicketsMailerTest < ActionMailer::TestCase
  test "created" do
    mail = TicketsMailer.created
    assert_equal "Created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "commented" do
    mail = TicketsMailer.commented
    assert_equal "Commented", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
