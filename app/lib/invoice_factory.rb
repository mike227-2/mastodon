class InvoiceFactory
  def self.with_one_position(amount, reference_id)
    invoice = Invoice.new(reference_id)
    invoice.add_purchase(Purchase.new(amount))
    invoice
  end
end

class Invoice
  attr_writer :client_id
  attr_reader :purchases

  def initialize(invoice_id)
    @invoice_id = invoice_id
    @purchases = []
  end

  def add_purchase(purchase)
    @purchases << purchase
  end

  def invoice_attributes
    {
      :client_id => @client_id,
      :invoice_id => @invoice_id,
      :purchases => @purchases.map(&:purchase_attributes)
    }
  end
end

class Purchase
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def purchase_attributes
    {
      :site => 'www.bigbuttbouncetwerk.com',
      :billing => {
        :currency => 'USD',
        :initial => {
          :amount => @amount,
        }
      }
    }
  end
end

