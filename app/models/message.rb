class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  field :author, type: String
  field :text, type: String
  field :k, type: Integer

  # default_scope desc(:created_at)

  belongs_to :dialog

  before_create :pusher

  def pusher
    dialog_id = self.dialog_id.to_s
    dialog = self.dialog
    if self.author == "admin"
      Pusher[dialog_id].trigger('message_send', { text: self.text, author: 'admin'})
    else
      Pusher['admin'].trigger('message_send', { id: dialog_id, text: self.text, author: 'parya' }) unless dialog.done
    end
  end

end
