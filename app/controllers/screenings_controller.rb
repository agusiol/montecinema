class ScreeningsController < ApplicationController
    def index
      @screenings = Screenings::UseCases::FindAll.new.call
      render json: Screenings::Representer.new(@screenings).basic
    end
  
    def show
      screening = Screenings::Repository.new.find_by(params[:id])
      render json: Screenings::Representer.new([screening]).extended
    end
  
    def create
      screening = Screenings::UseCases::Create.new.call(params: {
                  date: params[:screening][:date], 
                  movie_id: params[:movie_id],
                  cinema_hall_id: params[:cinema_hall_id] })
    
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
      params.require(:screening).permit(:date)
    end
  end
#     def index
#         @screenings = Screening.all
#         render json: @screenings
#     end

#     def show
#         set_screening
#         render json: @screening
#     end

#     def create
#         @cinema_hall = CinemaHall.find(params[:cinema_hall_id])
#         @screening = screening.find(params[:screening_id])
#         @screening = @cinema_hall.screenings.create(screening_params)
#         @screening.screening_id = @screening.id
#         @screening.seats = @cinema_hall.seats
#         if @screening.save
#             render json: @screening, status: :created
#         else
#             render json: @screening.errors, status: :unprocessable_entity
#         end

#     end

#     def update
#         set_screening
#         if @screening.update(screening_params)
#             render json: @screening
#         else
#             render json: @screening.errors, status: :unprocessable_entity
#         end
#     end

#     def destroy
#         set_screening
#         @screening.destroy
#         render json: {status: "deleted"}
#     end

#     private
#     def set_screening
#         @screening = Screening.find(params[:id])
#     end
        
#     def screening_params
#         params.require(:screening).permit(:date)
#     end

# end