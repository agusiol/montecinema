module  CinemaHalls
  module Validators
    class CinemaHallContract < Dry::Validation::Contract
      json do
     
          required(:name).value(:string)
          required(:capacity).value(:integer)
        
      end
    end
  end
end