class Dialog
  include Mongoid::Document
  include Mongoid::Timestamps
  field :ip, type: String
  field :coordinates, type: Array
  field :city, type: String
  field :url_start
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
