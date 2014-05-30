class Coordinate
  include Mongoid::Document
  field :location, type: Array

  index({ location: "2dsphere" })
  belongs_to :user

  def self.near(coordinates, distance)
    where(location: { "$near" => { "$geometry" => { type: "Point", coordinates: coordinates }, "$maxDistance" => distance}})
  end
end
