# frozen_string_literal: true

module Offline
  class TicketDesksController < ApplicationController
    def index
      @ticket_desks = TicketDesks::Repository.new.find_all
      render json: TicketDesks::Representer.new(@ticket_desks).basic
    end

    def show
      ticket_desk = TicketDesks::Repository.new.find_by(params[:id])
      render json: TicketDesks::Representer.new([ticket_desk]).extended
    end
  end
end
