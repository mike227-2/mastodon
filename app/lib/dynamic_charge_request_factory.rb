class DynamicChargeRequestFactory
  def self.charge_x(amount, reference_id)
    invoice = InvoiceFactory.with_one_position(amount, reference_id)
    DynamicChargeRequest.new(invoice).run
  end
end
