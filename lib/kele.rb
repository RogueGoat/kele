require 'httparty'
require 'json'

class Kele
attr_reader :email, :password
  include HTTParty
  base_url = "https://www.bloc.io/api/v1/"

  def initialize(email, password)
    api_url = 'https://www.bloc.io/api/v1/sessions'
    response = self.class.post(api_url, body: { email: email, password: password })
    puts "Invalid credentials! Please enter a valid email and/or password" if response.code == 404
    @auth_token = response['auth_token']
    puts @auth_token
  end
  
  def get_me
    api_url = 'https://www.bloc.io/api/v1/users/me'
    response = self.class.get(api_url, headers: { 'authorization' => @auth_token })
    @user = JSON.parse(response.body)
  end

# private

#   def api_url(direction)
#     "https://www.bloc.io/api/v1/#{direction}"
#   end

end