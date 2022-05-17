# frozen_string_literal: true

require 'singleton'

class ContentRestrictor
  include Singleton

  def unlocked_for?(status, account)
    found_purchase = StatusPurchase.find_by(status_id: status.id, account: account, state: :succeed)
    status.cost.nil? or !found_purchase.nil? # or status.account == account
  end

  def filter_locked_statuses(statuses, account)
    all_statuses = []

    statuses.each do |status|
      all_statuses.push(filter_locked_status(status, account))
    end
    all_statuses
  end

  def filter_locked_status(status, account)
    unless status.unlocked_for? account
      status.locked = true
      status.media_attachments_count = status.media_attachments.length
      status.media_attachments = []
      status.text = 'Locked'
    end
    status
  end
end
