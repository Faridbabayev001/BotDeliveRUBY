require 'net/http'
class BotDelive

  # BotDelive is a Push Notification and 2-factor authentication API service that works over the chat bots (Telegram and Messenger).
  # # @see https://botdelive.com/docs

  Endpoint = "https://botdelive.com/api/"
  VerifyUserUrl = "#{Endpoint}verifyAC"
  AuthenticateUrl = "#{Endpoint}sendAuth"
  PushNotificationUrl = "#{Endpoint}sendPush"

  def initialize(appId,secretKey)
    @appId = appId
    @secretKey = secretKey
  end

  # Verify the "Access Code"
  #
  # @param access_code [String]
  # @return [Json]
  def verify(access_code)
    if !access_code.to_s.empty?
      params = {:accessCode => access_code}
      _send_request(params, VerifyUserUrl)
    else
        raise "Access Code must be required"
    end
  end

  # Send 2-factor authentication request (long polling)
  #
  # @param user_id [String]
  # @return [Json]
  def auth(user_id)
    if !user_id.to_s.empty?
      params = {:userId => user_id}
      _send_request(params,AuthenticateUrl)
    else
      raise "User ID must be required"
    end
  end

  # Send Push Notification request
  #
  # @param user_id [String]
  # @return [Json]
  def push(user_id,message)
    if !user_id.to_s.empty?
      if !message.to_s.empty?
        params = {:userId => user_id, :message => message}
        _send_request(params,PushNotificationUrl)
      else
        raise "Message must be required"
      end
    else
      raise "User ID must be required"
    end
  end

  private
  def _send_request(params,request_uri) # :nodoc:
    uri = URI(request_uri)
    params[:appId] = @appId
    params[:secretKey] = @secretKey
    params[:platform] = 'ruby'
    uri.query = URI.encode_www_form(params)
    Net::HTTP.get_response(uri).body
  end
end