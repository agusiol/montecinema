class ScreeningsController < ApplicationController
    def index
      @screenings = Screenings::UseCases::FetchWithColumns.new.call(params[:cinema_hall_id],params[:movie_id])
      render json: Screenings::Representer.new(@screenings).basic
    end
  
    def show
      screening = Screenings::Repository.new.find_by(params[:id])
      render json: Screenings::Representer.new([screening]).extended
    end
  
    def create
     
      screening = Screenings::UseCases::Create.new.call(params: screening_params)
      
      if screening.valid?
          render json: screening, status: :created
        else
          render json: screening.errors, status: :unprocessable_entity
        end
    end
  
    def update
      screening = Screenings::UseCases::Update.new.call(id: params[:id], params: screening_params)
        if screening.valid?
            render json: screening
        else
            render json: screening.errors, status: :unprocessable_entity
        end
    end
  
    def destroy
      Screenings::UseCases::Delete.new.call(id: params[:id])
      render json: {status: "deleted"}
    end
  
    
  
    private
    
    def screening_params
      params.require(:screening).permit(:date,:cinema_hall_id, :movie_id)
    end
  end
