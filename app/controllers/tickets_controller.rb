# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    @tickets = Tickets::UseCases::FetchWithColumns.new.call(params[:reservation_id])
    render json: Tickets::Representer.new(@tickets).basic
  end

  def show
    ticket = Tickets::Repository.new.find_by(params[:id])
    render json: Tickets::Representer.new([ticket]).basic
  end

  private

  def ticket_params
    params.require(:ticket).permit(:reservation_id, :ticket_type, :price, :seat)
  end
end
