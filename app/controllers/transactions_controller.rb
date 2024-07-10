class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  CARD_LIMIT = 500

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
    @frequent_transactions = Transaction.group(:name, :amount).having('COUNT(*) >= ?', 3)
    @close_transactions = Transaction.where("amount > ? AND amount <= ?", CARD_LIMIT - 50, CARD_LIMIT).to_a
    @card_limit = CARD_LIMIT  # Pass the constant to the view
  end

  def history
    @transactions = Transaction.all
    @frequent_transactions = Transaction.group(:name, :amount).having('COUNT(*) >= ?', 3)
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    if params[:scheduled_transaction].present?
      @transaction.name = params[:scheduled_transaction][:name]
      @transaction.amount = params[:scheduled_transaction][:amount]
    end
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:name, :amount)
    end

    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:name, :amount)
    end


  def check_transactions

      # Define your card limit
      card_limit = 500.00
  
      # Retrieve transactions close to the card limit
      @close_transactions = Transaction.where("amount > ? AND amount <= ?", card_limit - 50, card_limit)
  
      if @close_transactions.count >= 3
        # Notify or take action for transactions close to the card limit
        @close_transactions.each do |transaction|
          puts "#{transaction.name} is close to the card limit. Amount: #{transaction.amount}"
          # You can perform additional actions here, like sending notifications or logging
        end
        render plain: "Notifications sent for transactions close to the card limit."
      else
        render plain: "No transactions are close to the card limit."
      end
    end
  end

