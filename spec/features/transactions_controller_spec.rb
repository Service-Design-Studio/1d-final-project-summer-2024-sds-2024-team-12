# spec/controllers/transactions_controller_spec.rb
require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, user: user) }

  before do
    allow(Current).to receive(:user).and_return(user)
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: transaction.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Transaction" do
        expect {
          post :create, params: { transaction: attributes_for(:transaction) }
        }.to change(Transaction, :count).by(1)
      end

      it "redirects to the created transaction" do
        post :create, params: { transaction: attributes_for(:transaction) }
        expect(response).to redirect_to(Transaction.last)
      end
    end

    context "with invalid params" do
      it "returns an unprocessable entity status" do
        post :create, params: { transaction: attributes_for(:transaction, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid params" do
      it "updates the requested transaction" do
        put :update, params: { id: transaction.id, transaction: { name: "Updated" } }
        transaction.reload
        expect(transaction.name).to eq("Updated")
      end

      it "redirects to the transaction" do
        put :update, params: { id: transaction.id, transaction: { name: "Updated" } }
        expect(response).to redirect_to(transaction)
      end
    end

    context "with invalid params" do
      it "returns an unprocessable entity status" do
        put :update, params: { id: transaction.id, transaction: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested transaction" do
      transaction # create the transaction
      expect {
        delete :destroy, params: { id: transaction.id }
      }.to change(Transaction, :count).by(-1)
    end

    it "redirects to the transactions list" do
      delete :destroy, params: { id: transaction.id }
      expect(response).to redirect_to(transactions_url)
    end
  end
end
