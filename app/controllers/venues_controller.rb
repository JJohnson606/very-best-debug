class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)
   
    render({ :template => "venues_templates/venue_list" })
  end

  def show
    my_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => my_id })
    @venue = matching_venues.at(0)
   
    render({ :template => "venues_templates/details" })
  end

  def create
    venue = Venue.new
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save

    redirect_to("/venues/#{venue.id}")
  end
  
  def update
    the_id = params.fetch("venue_id")
    
    @venue = Venue.find_by(id: the_id)
    if @venue

    @venue.address = params.fetch("query_address")
    @venue.name = params.fetch("query_name")
    @venue.neighborhood = params.fetch("query_neighborhood")
    @venue.save
    
    redirect_to("/venues/#{@venue.id}")
    else

    redirect_to("/venues")
    end
  end

  def destroy
    the_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.first
    venue.destroy

    redirect_to("/venues")
  end
end
