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

  def list
    @contacts = Contact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  def submit_contact
    @contact = Contact.new
    @contact.email = params[:email]
    @contact.college = params[:college]
    @contact.comment_text = params[:comment]
    @contact.save

    #if Notifier.submit("ratings@ratemyclass.com","Contact form submission",params).deliver
    #  data = {"status" => "ok", "message" => "E-mail sent!"}
    #else
    #  data = {"status" => "err", "message" => "E-mail could not be sent."}
    #end
    respond_to do |format|
      format.html { render "thanks" }
      #format.json { render json: @comments }
    end
  end
end