class MemsMailer < ActionMailer::Base
  default from: 'memsadmin@magest.com'
  #"magest.mailer@gmail.com"

  def versa_down(user, transcode)
  	@user = user
    @trans_code = transcode
  	case  @trans_code 
  	when 'VRS' then @subject = " Versa Operator Requested Assistance"
    when 'OPA' then @subject = " Offline Panel Assembly Requested Assistance"
    when 'NCN' then @subject = " Nucon Truss Assermbly Requested Assistance" 
    when 'RLF' then @subject = " Roll Former Operator Requested Assistance"  
    else @subject = @trans_code, " Operator requested Assistance"
    end	
    mail(to: @user, subject: @subject) 
    	#{}"Request for Assitance")
  end
end
