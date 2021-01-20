class ApplicationController < ActionController::API

    def encode_token(payload)
        JWT.encode(payload, ENV['JWT_SECRET'])
    end

    def auth_header
        request.headers['Authorization']
    end

    def decoded_token
        if auth_header
            token = auth_header.split(" ")[1]
            begin
                JWT.decode(token, ENV['JWT_SECRET'])
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user
        if decoded_token
            payload = decoded_token[0]
            user_id = payload['user_id']
            current_user = User.find(user_id)
        end
    end
    
end
