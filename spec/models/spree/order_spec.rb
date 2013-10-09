require 'spec_helper'

describe Spree::Order do
  let(:ordered_on) { Spree::GarbageCleaner::Config.cleanup_days_interval }

  context "class methods" do
    before do
      @order_one = Factory(:order, :created_at => (ordered_on+rand(10)).days.ago, :completed_at => nil)
      @order_two = Factory(:order, :created_at => (ordered_on+rand(10)).days.ago, :completed_at => nil)
      @order_three = Factory(:order)
    end

    it "has a garbage finder method" do
      Spree::Order.garbage.should == [@order_one, @order_two]
    end

    context ".destroy_garbage" do
      it "has a method to destroy garbage" do
        Spree::Order.destroy_garbage.should == [@order_one, @order_two]
        Spree::Order.garbage.count.should == 0
        Spree::Order.all.should include(@order_three)
      end

      it "destroys garbage in batches" do
        dummy_garbage = [@order_one, @order_two]
        Spree::Order.stub(:garbage).and_return(dummy_garbage)

        dummy_garbage.should_receive(:find_each).with(:batch_size => Spree::GarbageCleaner::Config.batch_size)
        Spree::Order.destroy_garbage
      end
    end
  end

  context "instance methods" do
    it "has a method that tells if order is garbage" do
      order = Factory.build(:order)
      order.should respond_to(:garbage?)
    end

    it "is garbage if not completed and past cleanup_days_interval" do
      order = Factory.build(:order, :created_at => ordered_on.days.ago, :completed_at => nil)
      order.garbage?.should be_true
    end

    it "is not garbage if not completed and not past cleanup_days_interval" do
      order = Factory.build(:order, :created_at => (ordered_on-1).days.ago, :completed_at => nil)
      order.garbage?.should be_false
    end

    it "is not garbage if completed and past cleanup_days_interval" do
      order = Factory.build(:order, :created_at => ordered_on.days.ago, :completed_at => Time.now)
      order.garbage?.should be_false
    end

    it "is not garbage if completed and not past cleanup_days_interval" do
      order = Factory.build(:order, :completed_at => Time.now)
      order.garbage?.should be_false
    end
  end
end
