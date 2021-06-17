# frozen_string_literal: true

class TicketDesksController < ApplicationController
  before_action :authenticate_user!
  before_action :staff_authorize!
  def index
    @ticket_desks = TicketDesks::Repository.new.find_all
    render json: TicketDesks::Representer.new(@ticket_desks).basic
  end

  def show
    ticket_desk = TicketDesks::Repository.new.find_by(params[:id])
    render json: TicketDesks::Representer.new([ticket_desk]).extended
  end

  def create
    ticket_desk = TicketDesks::UseCases::Create.new.call(params: ticket_desk_params)
    if ticket_desk.valid?
      render json: ticket_desk, status: :created
    else
      render json: ticket_desk.errors, status: :unprocessable_entity
    end
  end

  def update
    ticket_desk = TicketDesks::UseCases::Update.new.call(id: params[:id], params: ticket_desk_params)
    if ticket_desk.valid?
      render json: ticket_desk
    else
      render json: ticket_desk.errors, status: :unprocessable_entity
    end
  end

  def destroy
    TicketDesks::UseCases::Delete.new.call(id: params[:id])
    render json: { status: 'deleted' }
  end

  private

  def ticket_desk_params
    params.require(:ticket_desk).permit(:category)
  end
end
