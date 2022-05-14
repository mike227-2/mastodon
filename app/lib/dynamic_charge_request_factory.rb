class DynamicChargeRequestFactory
  def self.charge_x(amount, reference_id, base_url)
    invoice = InvoiceFactory.with_one_position(amount, reference_id)
    DynamicChargeRequest.new(invoice, base_url).run
  end
end
