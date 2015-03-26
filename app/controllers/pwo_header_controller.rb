class PwoHeaderController < ApplicationController

layout "mems"

def index
@workheads = PwoHeaders.new
end

def show
@workheads = PwoHeaders.where(status: [1,2])	
end

def update
end
    
	
end
