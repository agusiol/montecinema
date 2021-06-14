# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    @tickets = Tickets::Repository.new.fetch(reservation_id: params[:reservation_id])
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
