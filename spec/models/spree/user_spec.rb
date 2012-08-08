require 'spec_helper'

describe Spree::User do
  let(:created_on) { Spree::GarbageCleaner::Config.cleanup_days_interval }

  context "class methods" do
    before do
      @user_one = Spree::User.anonymous!   # garbage
      @user_two = Spree::User.anonymous!   # garbage
      @user_three = Spree::User.anonymous! # not garbage
      @user_four = Factory(:user)          # not garbage

      Factory(:order, :user => @user_one)
      Factory(:order, :user => @user_two)
      Factory(:completed_order_with_totals, :user => @user_three)

      @user_one.update_column(:created_at, (created_on+rand(10)).days.ago)
      @user_two.update_column(:created_at, (created_on+rand(10)).days.ago)
      @user_three.update_column(:created_at, (created_on+rand(10)).days.ago)
    end

    it "has a garbage finder method" do
      Spree::User.garbage.should == [@user_one, @user_two]
    end

    it "has a method to destroy garbage" do
      Spree::User.destroy_garbage.should == [@user_one, @user_two]
      Spree::User.garbage.count.should == 0
      Spree::User.all.should include(@user_three, @user_four)
    end
  end

  context "instance methods" do
    it "has a method that tells if order is garbage" do
      user = Factory.build(:user)
      user.should respond_to(:garbage?)
    end

    it "is garbage if anonymous and past cleanup_days_interval" do
      user = Spree::User.anonymous!
      user.update_column(:created_at, created_on.days.ago)
      user.garbage?.should be_true
    end

    it "is not garbage if anonymous and not past cleanup_days_interval" do
      user = Spree::User.anonymous!
      user.update_column(:created_at, (created_on-1).days.ago)
      user.garbage?.should be_false
    end

    it "is not garbage if not anonymous and past cleanup_days_interval" do
      user = Factory.build(:user, :created_at => created_on.days.ago)
      user.garbage?.should be_false
    end

    it "is not garbage if not anonymous and not past cleanup_days_interval" do
      user = Factory.build(:user)
      user.garbage?.should be_false
    end

    it "is not garbage if it has a completed order associated to" do
      user = Spree::User.anonymous!
      user.update_column(:created_at, created_on.days.ago)
      order = Factory(:completed_order_with_totals, :user => user)
      user.garbage?.should be_false
    end
  end
end