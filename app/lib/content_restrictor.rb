# frozen_string_literal: true

require 'singleton'

class ContentRestrictor
  include Singleton

  def unlocked_for?(status, account)
    found_purchase = StatusPurchase.where(status_id: status.id, account: account)
    status.cost.nil? or !found_purchase.nil? or status.account == account
  end

  def purchase_text(status)
    "This status is locked. Click #{link_to_purchase 'here', status} to purchase it for $ #{status.cost}."
  end

  def link_to_purchase(display_text, status)
    "https://example.com"
  end
end
