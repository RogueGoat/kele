require 'httparty'
require 'json'

class Kele
attr_reader :email, :password
  include HTTParty
  base_url = "https://www.bloc.io/api/v1/"

  def initialize(email, password)
    response = self.class.post(api_url("sessions"), body: { email: email, password: password })
    puts "Invalid credentials! Please enter a valid email and/or password" if response.code == 404
    @auth_token = response['auth_token']
    puts @auth_token
  end
  
  def get_me
    response = self.class.get(api_url("users/me"), headers: { 'authorization' => @auth_token })
    @user = JSON.parse(response.body)
  end
  
  def get_mentor_availability(mentor_id)
    # ryan's mentor id 456756
    response = self.class.get(api_url("mentors/#{mentor_id}/student_availability"), headers: { 'authorization' => @auth_token })
    mentor_availability = []
    response.each do |time|
      if time["booked"] == nil
        mentor_availability.push(time)
      else
       puts "This mentor has no availability"
      end
  end
    puts mentor_availability
  end

private

  def api_url(direction)
    "https://www.bloc.io/api/v1/#{direction}"
  end

end