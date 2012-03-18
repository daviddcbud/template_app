class SessionsController < ApplicationController
 def new
   
 end
 def reset_password
  @user= flash[:user]
 end
 def create
   user = User.find_by_email(params[:session][:email])
   failed_attempts=0
   if user
     failed_attempts=user.failed_password_attempts || 0
   end
   
   if failed_attempts >=5
        flash[:error]="Too many failed attempts"
        flash[:user]=user
        redirect_to reset_password_path
   else
      if user && user.authenticate(params[:session][:password])
        # Sign the user in and redirect to the user's show page.
         user.failed_password_attempts=0
         user.session_token = create_session_token
         user.save(validate:false)
         sign_in user
         redirect_to user
         
      else
        msg="Invalid email/password"
        if user
          
          failed_attempts = failed_attempts + 1
          user.failed_password_attempts=failed_attempts
          user.save(validate:false)
          if failed_attempts >=5
            flash[:user]=user
            flash[:error]="Too many failed attempts"
            redirect_to reset_password_path
          else
            # Create an error message and re-render the signin form.
            flash.now[:error]=msg
            render 'new'
          end
        
        else
          # Create an error message and re-render the signin form.
          flash.now[:error]=msg
          render 'new'
        end 
      end
  end
 end
 def destroy
   sign_out
   redirect_to root_path
 end
end
