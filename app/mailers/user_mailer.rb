class UserMailer < ApplicationMailer
    def approval_email(user)
        @user  = user
        mail(to: @user.email, subject: 'Trader Account Approved!')
    end
end
