class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  field :author, type: String
  field :text, type: String
  field :k, type: Integer
  
  belongs_to :dialog
  
  after_create :pusher
  
  def pusher
    if self.author == 'admin'
      # Pusher['52fe88a14d6163b5ad0d0000'].trigger('message', {text: 'fuck'})
      Pusher[self.dialog_id].trigger('message', { text: self.text, author: 'admin'})
    elsif self.author == 'parya'
      Pusher['admin'].trigger('message', { id: self.dialog.id.to_s, text: self.text, author: 'parya' })
    end
  end
  
end
