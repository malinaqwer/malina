class ParyaEmail < ActionMailer::Base
  default from: "42b027d2001e4bb24cf5@cloudmailin.net"

  def enter_email(id)
    @id = id
    mail(to: '42b027d2001e4bb24cf5@cloudmailin.net', subject: @id)
  end

end
