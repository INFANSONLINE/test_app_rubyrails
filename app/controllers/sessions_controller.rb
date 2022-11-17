class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password].downcase)
        session[:user_id] = user.id
        flash[:notice] = "Bienvenid@"
        redirect_to user
        else
        flash[:alert] =  "Email o contraseña incorrectos"
        redirect_to login_path
    end
    end


    def destroy
        session[:user_id] = nil
        flash[:notice] = "¡Gracias por utilizar TRIPSO!"
        redirect_to login_path
    end



end