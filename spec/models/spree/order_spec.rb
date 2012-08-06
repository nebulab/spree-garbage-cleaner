require 'spec_helper'

describe Spree::Order do
  context "when order is incomplete" do
    before do
       # # Field required to complete the order 
       # order.bill_address = Factory(:address)
       # order.ship_address = Factory(:address)
       # Factory(:inventory_unit, :order => order, :state => 'shipped')
    end
  end
end