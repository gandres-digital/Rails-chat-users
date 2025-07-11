module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      puts "Usuario conectado en ActionCable: #{current_user&.email}"

    end

    private

    def find_verified_user
      token = request.params[:token]
      puts "Token recibido en connection.rb: #{token}"
      return nil unless token
    
      payload = JwtService.decode(token)
      puts "Payload decodificado: #{payload.inspect}"
      return nil unless payload
    
      user = User.find_by(id: payload["user_id"])
      puts "Usuario encontrado: #{user&.email}"
      user
    rescue => e
      puts "Error en find_verified_user: #{e.message}"
      nil
    end
  end
end