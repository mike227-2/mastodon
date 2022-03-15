require 'lib_spec_helper'

RSpec.describe TransactionManager do
  it 'Test strategy determination' do

    account = Account.new

    strategy = TransactionManager.strategy_for_account(account)
    expect(strategy).to be_a JoinStrategy

    account = Account.new(epoch_member_id: 5)
    strategy = TransactionManager.strategy_for_account(account)
    expect(strategy).to be_a ChargeStrategy
  end
end
