class OrcidsController < ApplicationController
  include OrcidsHelper
  
  before_action :setup_orcid_access_token, only: [:index]
  
  # GET /orcids
  # GET /orcids.json
  def index
    # search box for RINGGOLD
    @orcid = Orcid.new
  end
  
  def ringgold_query
    redirect_to orcid_path(params[:orcid][:id], ringgold: params[:orcid][:ringgold])
  end
  
  def grid_query
    redirect_to orcid_path(params[:orcid][:id].gsub('.', '_'), grid: params[:orcid][:grid])
  end

  # GET /orcids/1
  # GET /orcids/1.json
  def show
    @orc_id = params[:id]
    
    if params[:ringgold] == "true"
      @orcids = search_for_ringgold
    elsif params[:grid] == "true"
      @orcids = search_for_grid
    else
      @orcids = []
    end
  end

  # # GET /orcids/new
  # def new
  #   @orcid = Orcid.new
  # end

  # # GET /orcids/1/edit
  # def edit
  # end

  # # POST /orcids
  # # POST /orcids.json
  # def create
  #   @orcid = Orcid.new(orcid_params)

  #   respond_to do |format|
  #     if @orcid.save
  #       format.html { redirect_to @orcid, notice: 'Orcid was successfully created.' }
  #       format.json { render :show, status: :created, location: @orcid }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @orcid.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /orcids/1
  # # PATCH/PUT /orcids/1.json
  # def update
  #   respond_to do |format|
  #     if @orcid.update(orcid_params)
  #       format.html { redirect_to @orcid, notice: 'Orcid was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @orcid }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @orcid.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /orcids/1
  # # DELETE /orcids/1.json
  # def destroy
  #   @orcid.destroy
  #   respond_to do |format|
  #     format.html { redirect_to orcids_url, notice: 'Orcid was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_orcid
    #   @orcid = nil
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orcid_params
      params.require(:orcid).permit(:ringgold, :grid)
    end
end
