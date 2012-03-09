class ContactController < ApplicationController
  # GET /comments
  # GET /comments.json
  def index
    @page_title = "Contact Us"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  def submit_contact
    if Notifier.submit("ratings@ratemyclass.com","Contact form submission",params).deliver
      data = {"status" => "ok", "message" => "E-mail sent!"}
    else
      data = {"status" => "err", "message" => "E-mail could not be sent."}
    end
    respond_to do |format|
      format.html { redirect_to categories_path }
      format.json { render json: @comments }
    end
  end
end