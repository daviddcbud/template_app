class SessionsController < ApplicationController
 def new
   
 end
 def create
   user = User.find_by_email(params[:session][:email])
  if user && user.authenticate(params[:session][:password])
    # Sign the user in and redirect to the user's show page.
     user.session_token = create_session_token
     user.save(validate:false)
     sign_in user
     redirect_to user
     
  else
    # Create an error message and re-render the signin form.
    flash.now[:error]="Invalid email/password"
    render 'new'
  end
 end
 def destroy
   sign_out
   redirect_to root_path
 end
end
