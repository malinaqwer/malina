class Dialog
  include Mongoid::Document
  field :ip, type: String
  field :coordinates, type: Array
  field :city, type: String
  
  has_many :messages
  
  
  # before_create :define_location
  
  
  def define_location
    self.coordinates = geocoder request.remote_ip
    self.city = geocoder request.remote_ip
    self.save
  end
  
  def geocoder
    
  end
    
end
