require "rails_helper"

RSpec.describe CinemaHall, type: :model do #:type => :model is it the same?
    subject {
        described_class.new(name: "Anything",
                            capacity: 100,
                            )
    }
    
    it "is valid with name, capacity as a number " do
        expect(subject).to be_valid
    end

    it "is invalid without name" do
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it "is invalid without capacity" do
        subject.capacity = nil
        expect(subject).to_not be_valid
    end

    it "is invalid with capacity as string" do
        subject.capacity ="ABC"
        expect(subject).to_not be_valid
    end

end