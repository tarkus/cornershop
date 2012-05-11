class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
		@loan_histories = LoanHistory.joins(:medium).where("user_id = ?", params[:id]).order("rent_start")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

	def top
		@top_users = User.find_by_sql(
			"SELECT DISTINCT name, surname, team, position, (SELECT COUNT(*) FROM loan_histories WHERE loan_histories.user_id = users.id) AS rentals
			FROM users, loan_histories 
			WHERE loan_histories.user_id = users.id 
			ORDER BY rentals DESC")

		respond_to do |format|
      format.html # top.html.erb
      format.json { render json: @top_users }
		end
	end

	def overdue
		@overdue_users = User.find_by_sql(
			"SELECT DISTINCT users.id, name, surname, team, position, 
				(SELECT COUNT(*) FROM loan_histories 
					WHERE loan_histories.user_id = users.id 
					AND (loan_histories.rent_effective > loan_histories.rent_estimated 
					OR (loan_histories.rent_effective IS NULL AND CURDATE() > loan_histories.rent_estimated)))
					AS overdue 
			FROM users, loan_histories 
			WHERE loan_histories.user_id = users.id 
			ORDER BY overdue DESC")

		respond_to do |format|
      format.html # overdue.html.erb
      format.json { render json: @overdue_users }
		end
	end

  def forgiveness
    @late_returns = LoanHistory.where("user_id = ?", params[:id])

    unless @late_returns.nil? or @late_returns.empty?
			@late_returns.each do |late|
				if !late.rent_effective.nil? and late.rent_effective > late.rent_estimated
					late.rent_effective = late.rent_estimated
					late.save
				end
			end
    end

    #find_by_sql("UPDATE loan_histories SET rent_effective=rent_estimated
    #  WHERE rent_effective > rent_estimated AND user_id=?", params[:user_id])

    respond_to do |format|
			if @late_returns.nil? or @late_returns.empty?
				format.html { 
					redirect_to '/users/overdue', notice: "User #{params[:id]} does not exist or has no loan history." 
				}
				format.json { head :no_content }
			else
				format.html { redirect_to '/users/overdue', notice: "User #{params[:id]} has been forgiven and no longer has any overdue entries!" }
				format.json { head :no_content }
			end
    end
	end
end
