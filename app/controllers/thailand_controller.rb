class ThailandController < ApplicationController
  before_action :set_promptpay, only: %i[ show edit update destroy ]

  def promptpay
    @promptpay = Promptpay.new
    render :new
  end

  # GET /promptpays or /promptpays.json
  def index
    @promptpays = Promptpay.all
  end

  def history
    @promptpays = Promptpay.all
  end

  # GET /promptpays/1 or /promptpays/1.json
  def show
  end

  # GET /promptpays/new
  def new
    @promptpay = Promptpay.new
  end

  # GET /promptpays/1/edit
  def edit
  end

  # POST /promptpays or /promptpays.json
  def create
    @promptpay = Promptpay.new(promptpay_params)

    respond_to do |format|
      if @promptpay.save
        format.html { redirect_to root_path, notice: "Transaction was successfully created."}
        format.json { render :show, status: :created, location: @promptpay }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @promptpay.errors, status: :unprocessable_entity }
      end
    end
  end



  # PATCH/PUT /promptpays/1 or /promptpays/1.json
  def update
    respond_to do |format|
      if @promptpay.update(promptpay_params)
        format.html { redirect_to promptpay_url(@promptpay), notice: "Promptpay transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @promptpay }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @promptpay.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promptpays/1 or /promptpays/1.json
  def destroy
    @promptpay.destroy

    respond_to do |format|
      format.html { redirect_to promptpays_url, notice: "Promptpay transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promptpay
      @promptpay = Promptpay.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def promptpay_params
      params.require(:promptpay).permit(:phone_number, :amount)
    end

    # Validations or additional helper methods (adjust as needed)
    def valid_phone_number?(phone)
      phone.match?(/\A\d{9}\z/)
    end
end
