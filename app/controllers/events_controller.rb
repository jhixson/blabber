class EventsController < ApplicationController
  before_filter :authenticate_user!

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @comments = Comment.find_all_by_event_id(@event.id)
    @comment = Comment.new
    @page_title = "Rate #{@event.name}"
    @show_heart = true
    @faved = Favorite.where(:user_id => current_user.id, :event_id => @event.id)
    @heart_active = !@faved.blank? ? ' active' : ''
    @votes = @event.votes
    @rating = 0
    @data = []

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def rate
    @event = Event.find(params[:id])
    @page_title = "Rate #{@event.name}"
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # POST /events/1/vote_up
  def vote_up
    @event = Event.find(params[:id])
    @interval = @event.vote_interval
    @last_vote = @event.votes.last
    current_user.vote_for(@event) if Time.now - @last_vote.created_at >= @interval
    respond_to do |format|
      format.html { render 'rating_result' }
      format.js { render 'vote_result' }
    end
  end

  # POST /events/1/vote_down
  def vote_down
    @event = Event.find(params[:id])
    @interval = @event.vote_interval
    @last_vote = @event.votes.last
    current_user.vote_against(@event) if Time.now - @last_vote.created_at >= @interval
    respond_to do |format|
      format.html { render 'rating_result' }
      format.js { render 'vote_result' }
    end
  end

  def rating_result

  end

  # GET /events/1/favorite
  def favorite
    @event = Event.find(params[:id])
    @fav = Favorite.find_all_by_event_id(@event.id)
    if @fav.count == 0
      @fav = Favorite.new
      @fav.user_id = current_user.id
      @fav.event_id = @event.id
      @fav.save
      @favorite_message = "Added to favorites."
    else
      @fav.first.destroy
      @favorite_message = "Removed from favorites."
    end
    respond_to do |format|
      #format.html 
      #format.js { render 'vote_result' }
      format.js { render :nothing => true }
    end
  end

  # GET /events/favorites
  def favorites
    @favorites = Favorite.find_all_by_user_id(current_user.id)
    @page_title = "My Classes"
    respond_to do |format|
      format.html 
      #format.js { render 'vote_result' }
    end
  end

  # GET /events/1/votes
  def votes
    @event = Event.find(params[:id])
    @votes = @event.votes
    @rating = 0
    @data = []
    @page_title = "Rating"
    respond_to do |format|
      format.html 
      #format.js { render 'vote_result' }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
