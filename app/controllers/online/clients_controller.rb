# frozen_string_literal: true

module Online
  class ClientsController < ApplicationController
    def index
      @clients = Clients::Repository.new.find_all
      render json: Clients::Representer.new(@clients).basic
    end

    def show
      client = Clients::Repository.new.find_by(params[:id])
      render json: Clients::Representer.new([client]).extended
    end

    def create
      client = Clients::UseCases::Create.new.call(params: client_params)
      if client.valid?
        render json: client, status: :created
      else
        render json: client.errors, status: :unprocessable_entity
      end
    end

    def update
      client = Clients::UseCases::Update.new.call(id: params[:id], params: client_params)
      if client.valid?
        render json: client
      else
        render json: client.errors, status: :unprocessable_entity
      end
    end

    def destroy
      Clients::UseCases::Delete.new.call(id: params[:id])
      render json: { status: 'deleted' }
    end

    private

    def client_params
      params.require(:client).permit(:name, :email, :age)
    end
  end
end
