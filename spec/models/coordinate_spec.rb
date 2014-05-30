require 'spec_helper'

describe Coordinate, :type => :model do
  let!(:warsaw) { Coordinate.create(location: [21.016667, 52.233333]) }
  let!(:stockholm) { Coordinate.create(location: [18.068611, 59.329444]) }

  it "finds places nearby" do
    # Warsaw is about 810km from Stockholm

    expect(Coordinate.near(warsaw.location, 820000)).to eq [warsaw, stockholm]
    expect(Coordinate.near(warsaw.location, 800000)).to eq [warsaw]
  end

end
