class Helpers
 
    def self.is_logged_in?(session)
        !!session[:id]
    end

    def self.current_user(session)
        if session[:id] != nil
            User.find(session[:id])
        end 
    end

    def self.valid_params?
        params[:user].none? |k,v| do 
            v == ""
        end 
    end 

end 