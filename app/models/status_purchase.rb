# == Schema Information
#
# Table name: status_purchases
#
#  id                   :bigint(8)        not null, primary key
#  status_id            :bigint(8)
#  account_id           :bigint(8)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  amount               :float
#  state                :integer
#  epoch_transaction_id :string
#
class StatusPurchase < ApplicationRecord
  belongs_to :status
  belongs_to :account

  enum state: {
    pending: 0,
    aborted: 1,
    succeed: 2,
  }
end
