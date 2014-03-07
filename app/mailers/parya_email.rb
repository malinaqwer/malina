class ParyaEmail < ActionMailer::Base
  default from: "42b027d2001e4bb24cf5@cloudmailin.net"

  def enter(id)
    @dialog = Dialog.find id
    @id = id
    mail(to: '1000xxxtest@gmail.com', subject: @id)
  end

end


p = {"plain"=>"",
  "html"=>"<div>1</div><div>2</div><div>3</div><div>4</div><div>5</div><div>6</div><div>7</div>\n",
  "reply_plain"=>"",
  "headers"=>{
    "Received"=>{
      "0"=>"from web16g.yandex.ru (web16g.yandex.ru [95.108.252.116]) by forward18.mail.yandex.net (Yandex) with ESMTP id B89B51782C8B for <42b027d2001e4bb24cf5@cloudmailin.net>; Thu, 06 Mar 2014 20:46:04 +0400",
      "1"=>"from 127.0.0.1 (localhost [127.0.0.1]) by web16g.yandex.ru (Yandex) with ESMTP id 69F9B800EBA; Thu, 06 Mar 2014 20:46:04 +0400",
      "2"=>"from [77.242.100.78] ([77.242.100.78]) by web16g.yandex.ru with HTTP; Thu, 06 Mar 2014 20:46:04 +0400"},
      "Date"=>"Thu, 06 Mar 2014 20:46:04 +0400",
      "From"=>"\"Соловьев Артем\" <yandeexart@ya.ru>",
      "To"=>"42b027d2001e4bb24cf5@cloudmailin.net",
      "Message-ID"=>"<132911394124364@web16g.yandex.ru>",
      "Subject"=>"2938457hgkjf9834bjfffd87",
      "Mime-Version"=>"1.0",
      "Content-Transfer-Encoding"=>"7bit",
      "DKIM-Signature"=>"v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1394124364; bh=jN848yE8Qpg9r4U/QQq3xlPrsgBy90aMQLGcodLDhSc=; h=From:To:Subject:Date; b=UFY9KF/8aq3xesibKXUJKCiN7/b5EsYDzVBLCNiqpe0uV4hF9QrYQvlHvw5sN3/uF EKHVxvYGlYVX6B+6s8Gx7r+2tGC/9rxaVaGmnGsRnfvacRJNMTrBcfv3iW9mQXl/Fa lWrKsVP9dGMRYVlKtzxSbUyMzfoHmjG/FfajkiY4=",
      "Envelope-From"=>"yandeexart@yandex.ru",
      "X-Mailer"=>"Yamail [ http://yandex.ru ] 5.0"},
      "envelope"=>{
        "to"=>"42b027d2001e4bb24cf5@cloudmailin.net",
        "recipients"=>{
          "0"=>"42b027d2001e4bb24cf5@cloudmailin.net"},
          "from"=>"yandeexart@ya.ru",
          "helo_domain"=>"forward18.mail.yandex.net",
          "remote_ip"=>"95.108.253.143",
          "spf"=>{
            "result"=>"neutral",
            "domain"=>"ya.ru"
          }
        }
      }
