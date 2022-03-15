class TransactionManager
  def initialize(hmac)
    @hmac = hmac
  end

  def charge_for_status_uri(account, status)
    strategy_for_account(account).execute(account, status).build_uri(@hmac)
  end

  def strategy_for_account(account)
    if account.epoch_member_id.nil?
      return JoinStrategy.new
    end
    ChargeStrategy.new
  end
end

class JoinStrategy
  def execute(account, status)
    request_hash = {
      street: account.street,
      city: account.city,
      state: account.state,
      phone: account.phone,
    }
    JoinRequest.new(request_hash)
  end
end

class ChargeStrategy
  def execute(account, status)
    ChargeRequestFactory.new("Post #{status.id} by #{status.account.username}", status.cost, account.epoch_member_id, '', '')
  end
end
