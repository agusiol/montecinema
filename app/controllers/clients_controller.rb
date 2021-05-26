class ClientsController < ApplicationController
    before_action :set_client, only: [:show, :update, :destroy]
    def index
        @clients = Client.all
        
        render json: @clients
    end

    def show
        render json: @client
    end

    def create
        @client = Client.new(client_params)
        @ticket_desk = TicketDesk.find(params[:ticket_desk_id])
        if @ticket_desk.type == "offline"
            @client.real_user = false
        else
            @client.real_user = false
        end
            
        
        if @client.save
            render json: @client, status: :created
        else
            render json: @client.errors, status: :unprocessable_entity
        end

    end

    def update
        if @client.update(clients_params)
            render json: @client
        else
            render json: @client.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @client.destroy
    end

    private
    def set_client
        @client = Client.find(params[:id])
    end
        
    def client_params
        params.require(:client).permit(:name, :email, :age)
    end


end