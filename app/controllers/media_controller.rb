class MediaController < ApplicationController
  # GET /media
  # GET /media.json
  def index
    @media = Medium.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media }
    end
  end

  # GET /media/1
  # GET /media/1.json
  def show
    @medium = Medium.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @medium }
    end
  end

  # GET /media/new
  # GET /media/new.json
  def new
    @medium = Medium.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medium }
    end
  end

  # GET /media/1/edit
  def edit
    @medium = Medium.find(params[:id])
  end

  # POST /media
  # POST /media.json
  def create
    @medium = Medium.new(params[:medium])

    respond_to do |format|
      if @medium.save
        format.html { redirect_to @medium, notice: 'Medium was successfully created.' }
        format.json { render json: @medium, status: :created, location: @medium }
      else
        format.html { render action: "new" }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /media/1
  # PUT /media/1.json
  def update
    @medium = Medium.find(params[:id])

    respond_to do |format|
      if @medium.update_attributes(params[:medium])
        format.html { redirect_to @medium, notice: 'Medium was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media/1
  # DELETE /media/1.json
  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy

    respond_to do |format|
      format.html { redirect_to media_url }
      format.json { head :no_content }
    end
  end

	def search
		@media = Medium.where("title LIKE ?", "%#{params[:q]}%")
		unless params[:media_type].empty?
			@media = @media.where("media_type = ?", params[:media_type])
		end
		unless params[:year].empty?
			@media = @media.where("year = ?", params[:year])
		end
		unless params[:availability].empty?
			@media = @media.where("availability = ?", params[:availability])
		end
		
		@search_result = true
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @media }
    end
	end

	def cast
		@media = Medium.where("cast LIKE ?", "%#{params[:cast]}%")
		
		@search_result = true
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @media }
    end
	end
end
