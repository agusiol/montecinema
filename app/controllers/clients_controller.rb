class ClientsController < ApplicationController
  before_action: only: [:show, :update, :destroy]
  def index
      @clients = Client.all
      
      render json: @clients
  end

  def show
    set_client
      render json: @client
  end

  def create
      @client = Client.new(client_params)
      @ticket_desk = TicketDesk.find(params[:ticket_desk_id])
      if @ticket_desk.type == "offline"
          @client.real_user = false
      else
          @client.real_user = true
      end
          
      
      if @client.save
          render json: @client, status: :created
      else
          render json: @client.errors, status: :unprocessable_entity
      end

  end

  def update
      set_client
      if @client.update(clients_params)
          render json: @client
      else
          render json: @client.errors, status: :unprocessable_entity
      end
  end

  def destroy
      set_client
      @client.destroy
      render json: {status: "deleted"}
  end

  private
  def set_client
      @client = Client.find(params[:id])
  end
      
  def client_params
      params.require(:client).permit(:name, :email, :age)
  end


end