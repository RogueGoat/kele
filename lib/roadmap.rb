require 'httparty'
require 'json'

module Roadmap
  include HTTParty
  # base_url = "https://www.bloc.io/api/v1/"
     
  def get_roadmap(roadmap_id)
    response = self.class.get(api_url("roadmaps/#{roadmap_id}"), headers: { 'authorization' => @auth_token })
    @roadmap = JSON.parse(response.body)
  end
  
  def get_checkpoint(checkpoint_id)
     response = self.class.get(api_url("checkpoints/#{checkpoint_id}"), headers: { 'authorization' => @auth_token })
     @checkpoints = JSON.parse(response.body)
  end

private

  def api_url(direction)
    "https://www.bloc.io/api/v1/#{direction}"
  end
end