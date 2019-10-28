RSpec.describe 'Order' do
  let(:warehouse) { Warehouse.new }

  before(:each) do
    warehouse.add('Gucci boots', 50)
  end

  context 'when warehouse has enough of the product' do
    let(:order) { Order.new('Gucci boots', 50) }
    order.fill(warehouse)

    it 'fills the order' do
      expect(order.is_filled).to_be truthy
    end

    it 'subtracts the product from warehouse inventory' do
      expect(warehouse.get_inventory('Gucci boots')).to_be(0)
    end
  end

  context 'when warehouse does not have enough of the product' do
    let(:order) { Order.new('Gucci boots', 51) }
    order.fill(warehouse)

    it 'does not fulfill the order' do
      expect(order.is_filled).to_be falsey
    end

    it 'does not subtract the product from warehouse inventory' do
      expect(warehouse.get_inventory('Gucci boots')).to_be(50)
    end
  end
end
