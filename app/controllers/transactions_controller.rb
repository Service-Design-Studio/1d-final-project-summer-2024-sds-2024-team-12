class TransactionsController < ApplicationController
  before_action :set_current_user
  before_action :check_if_user

  before_action :set_transaction, only: %i[show edit update destroy]
  CARD_LIMIT = 500

  # GET /transactions or /transactions.json
  def index
    @transactions = Current.user.transactions
    @frequent_transactions = Current.user.transactions.group(:name, :amount)
                                    .having('COUNT(*) >= ?', 3)
                                    .select('name, amount, COUNT(*) as count')

    @frequent_transactions_with_dates = @frequent_transactions.map do |transaction|
      history = Current.user.transactions.where(name: transaction.name, amount: transaction.amount).order(:created_at).pluck(:created_at)
      {
        name: transaction.name,
        amount: transaction.amount,
        dates: history
      }
    end

    @close_transactions = Current.user.transactions.where("amount > ? AND amount <= ?", CARD_LIMIT - 50, CARD_LIMIT).to_a
    @card_limit = CARD_LIMIT  # Pass the constant to the view
    @suggestions = Current.user.suggestions.where(user_dismissed: false).order(created_at: :desc)
  end

  def history
    @transactions = Current.user.transactions
    @frequent_transactions = Current.user.transactions.group(:name, :amount).having('COUNT(*) >= ?', 3)
  end

  def suggestions
    @suggestions = Current.user.suggestions.where(user_dismissed: false).order(created_at: :desc)
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Current.user.transactions.new
    @transaction.name = params[:mobile_number] if params[:mobile_number].present?
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
    @transaction = Current.user.transactions.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        if create_suggestion_if_frequent(@transaction)
          flash[:suggestion_created] = true
        end
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

  # GET /transactions/enter
  def enter
    # This action will just render the form
  end

  # def search
  #   query = params[:query]
  #   path = params[:path]

  #   if path.present?
  #     case path
  #     when 'Change Limit'
  #       redirect_to cardlimit_paynow_path
  #     # Add more cases for different paths
  #     else
  #       redirect_to root_path, alert: "Invalid path"
  #     end
  #   else
  #     redirect_to root_path, alert: "Query or path missing"
  #   end
  # end

  def search_suggestions
    # No need for query handling here
    # Just handle routing based on the input value
    path = params[:path]

    case path
    when 'Local Transfer Limit'
      redirect_to new_cardlimit_path
    else
      redirect_to root_path, alert: "Invalid path"
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Current.user.transactions.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:name, :amount)
  end

  def check_transactions
    # Define your card limit
    card_limit = 500.00

    # Retrieve transactions close to the card limit
    @close_transactions = Current.user.transactions.where("amount > ? AND amount <= ?", card_limit - 50, card_limit)

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

  def create_suggestion_if_frequent(transaction)
    @frequent_transactions = Current.user.transactions
                                    .where(name: transaction.name, amount: transaction.amount)
                                    .group(:name, :amount)
                                    .having('COUNT(*) >= ?', 3)
                                    .select('name, amount, COUNT(*) as count')

    suggestion_created = false
    @frequent_transactions.each do |frequent_transaction|
      unless Current.user.suggestions.exists?(suggestion_type: "FrequentTransaction", content: transaction_content(frequent_transaction))
        Suggestion.create(
          suggestion_type: "FrequentTransaction",
          content: transaction_content(frequent_transaction),
          link_url: schedule_payment_url(frequent_transaction),
          user_dismissed: false,
          user: Current.user
        )
        suggestion_created = true
      end
    end
    suggestion_created
  end

  def transaction_content(transaction)
    "We noticed you frequently paid #{transaction.name} #{transaction.amount}. Would you like to schedule this payment?"
  end

  def schedule_payment_url(transaction)
    new_scheduled_transaction_url(
      scheduled_transaction: {
        name: transaction.name,
        amount: transaction.amount
      }
    )
  end

end
