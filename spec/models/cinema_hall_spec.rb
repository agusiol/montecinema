require "rails_helper"

RSpec.describe CinemaHall, type: :model do
    subject {
        described_class.new(name: "Anything",
                            capacity: 100,
                            )
    }
    # it "is invalid without name" do
    #     subject.name = nil
    #     expect(subject).to_not be_valid
    # end

    describe "validations" do
        context "when all params are passed" do
          it 'creates hall with valid number and capacity' do   
            expect(subject).to be_valid  
          end
        end
      
        describe "#capacity" do
          context "when there is no capacity" do
              it "is invalid" do
                subject.capacity = nil        
                expect(subject).to_not be_valid
              end
           end
           
          context "when capacity is a string" do
              it "is invalid" do
                subject.capacity = "ABC"        
                expect(subject).to_not be_valid
              end
           end
        end

        describe '#name' do
            context "when there is no name" do
                it "is invalid" do
                  subject.name = nil        
                  expect(subject).to_not be_valid
                end
             end
        end
    end

end