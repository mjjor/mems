class MediaController < ApplicationController
  
  layout 'mems_landing'
   
  before_action :confirm_logged_in
  before_action :confirm_page_access

  def index
  	@project_poster = "Harrahs-Murphy-Casino-and-Hotel-Artist-Rendering.jpg"
  	@project_name = 'Harrahs Cherokee Valley River Casino'
  end

  def show
  	@media_name = "Magest_installation_webrip.mp4"
  	@project_name = 'Harrahs Cherokee Valley River Casino'
  	@page_title = 'Harrahs Cherokee Valley River Casino'
  	render stream: true
  end

private

def confirm_page_access
      found_page_access = UserSecurity.where(:userid => session[:user_id], 
                                             :module => 'media',
                                            :sub_module => 'index').first
      unless found_page_access
         flash[:notice] = "You do not have access to the requested page." 
         redirect_to(:controller => 'mems_login', :action => 'index.html')
      return false
      else return true
      end
  end

end
