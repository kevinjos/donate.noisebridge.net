class PaypalNotification < ActiveRecord::Base
  PRODUCTION_IPN_URL = "https://www.paypal.com/cgi-bin/webscr?cmd=_notify-validate".freeze
  DEVELOPMENT_IPN_URL = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate".freeze
  IPN_VERIFY_URL = Rails.env.production? ? PRODUCTION_IPN_URL : DEVELOPMENT_IPN_URL

  def self.verify_raw_payload(raw_payload)
    HTTParty.post(IPN_VERIFY_URL, body: raw_payload).body == "VERIFIED"
  rescue StandardError
    false
  end

  def self.create_from_payload(payload)
    create!(
      notification_id: payload["txn_id"],
      payload: payload
    )
  end
end
