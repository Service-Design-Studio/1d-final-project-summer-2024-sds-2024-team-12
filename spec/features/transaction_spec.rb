gpt rspec: # spec/models/transaction_spec.rb
require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user) { create(:user) }
  let(:transaction) { build(:transaction, user: user) }

  it "is valid with valid attributes" do
    expect(transaction).to be_valid
  end

  it "is not valid without a name" do
    transaction.name = nil
    expect(transaction).to_not be_valid
  end

  it "is not valid with an amount less than or equal to 0" do
    transaction.amount = 0
    expect(transaction).to_not be_valid
  end

  it "is not valid with more than two decimal places in amount" do
    transaction.amount = 10.123
    expect(transaction).to_not be_valid
  end

  it "is valid with exactly two decimal places in amount" do
    transaction.amount = 10.12
    expect(transaction).to be_valid
  end

  it "is valid with an integer amount" do
    transaction.amount = 10
    expect(transaction).to be_valid
  end

  describe ".recurring_transactions" do
    before do
      create_list(:transaction, 3, name: "Recurring", amount: 10.00, user: user)
    end

    it "returns recurring transactions with a count greater than or equal to the threshold" do
      result = Transaction.recurring_transactions
      expect(result).to include(["Recurring", 10.00])
    end
  end
end
