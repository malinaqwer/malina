class DialogsController < ApplicationController
  before_action :set_dialog, only: [:show, :edit, :update, :destroy]

  # GET /dialogs
  # GET /dialogs.json
  def index
    @dialogs = Dialog.all
  end

  # GET /dialogs/1
  # GET /dialogs/1.json
  def show
  end

  # GET /dialogs/new
  def new
    @dialog = Dialog.new
  end

  # GET /dialogs/1/edit
  def edit
  end


  def enter
    if params[:on].present?
      @dialog = Dialog.where(id: params[:on]).first || Dialog.create(ip: request.remote_ip)
    else
      @dialog = Dialog.create(ip: request.remote_ip)
    end
    Pusher['admin'].trigger('enter', { on: @dialog.id.to_s, path: params[:path], city: @dialog.city, ip: @dialog.ip, coord: @dialog.coordinates, new: @dialog.new_record? })
    render json: {on: @dialog.id.to_s, status: 'ok', messages: @dialog.messages }
  end


  # POST /dialogs
  # POST /dialogs.json
  def create
    @dialog = Dialog.new(dialog_params)

    respond_to do |format|
      if @dialog.save
        format.html { redirect_to @dialog, notice: 'Dialog was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dialog }
      else
        format.html { render action: 'new' }
        format.json { render json: @dialog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dialogs/1
  # PATCH/PUT /dialogs/1.json
  def update
    respond_to do |format|
      if @dialog.update(dialog_params)
        format.html { redirect_to @dialog, notice: 'Dialog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dialog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dialogs/1
  # DELETE /dialogs/1.json
  def destroy
    @dialog.destroy
    respond_to do |format|
      format.html { redirect_to dialogs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dialog
      @dialog = Dialog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dialog_params
      params.require(:dialog).permit(:ip, :coordinates, :city)
    end
end
