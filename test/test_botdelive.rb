require 'minitest/autorun'
require 'botdelive'

class BotDeliveTest < Minitest::Test
  APP_ID = "SyT8Pdf67"
  SECRET_KEY = "Ivfh-uFH88ILSSth5rOWbAQoNtYVIKz0EAz_up-t"

  def setup
    @bd = BotDelive.new(APP_ID,SECRET_KEY)
  end

  def test_user_verify
    @bd.verify("B1o2vufa7")
  rescue RuntimeError => e
    assert_equal('Access Code must be required', e.message)
  end

  def test_authentication_user
    @bd.auth("xPdDzngBRwm8CGkSj4I9Abi-2gYNXz6uO0jOYq43")
  rescue RuntimeError => e
    assert_equal('User ID must be required', e.message)
  end

  def test_push_notification
    @bd.push("xPdDzngBRwm8CGkSj4I9Abi-2gYNXz6uO0jOYq43","From unit test")
  rescue RuntimeError => e
    assert_equal('User ID must be required', e.message)
    assert_equal('Message must be required', e.message)
  end

end