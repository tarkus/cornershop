class LoanHistoriesController < ApplicationController
  # GET /loan_histories
  # GET /loan_histories.json
  def index
    @loan_histories = LoanHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @loan_histories }
    end
  end

  # GET /loan_histories/1
  # GET /loan_histories/1.json
  def show
    @loan_history = LoanHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @loan_history }
    end
  end

  # GET /loan_histories/new
  # GET /loan_histories/new.json
  def new
    @loan_history = LoanHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @loan_history }
    end
  end

  # GET /loan_histories/1/edit
  def edit
    @loan_history = LoanHistory.find(params[:id])
  end

  # POST /loan_histories
  # POST /loan_histories.json
  def create
    @loan_history = LoanHistory.new(params[:loan_history])

    respond_to do |format|
      if @loan_history.save
        format.html { redirect_to @loan_history, notice: 'Loan history was successfully created.' }
        format.json { render json: @loan_history, status: :created, location: @loan_history }
      else
        format.html { render action: "new" }
        format.json { render json: @loan_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /loan_histories/1
  # PUT /loan_histories/1.json
  def update
    @loan_history = LoanHistory.find(params[:id])

    respond_to do |format|
      if @loan_history.update_attributes(params[:loan_history])
        format.html { redirect_to @loan_history, notice: 'Loan history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @loan_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loan_histories/1
  # DELETE /loan_histories/1.json
  def destroy
    @loan_history = LoanHistory.find(params[:id])
    @loan_history.destroy

    respond_to do |format|
      format.html { redirect_to loan_histories_url }
      format.json { head :no_content }
    end
  end
end
