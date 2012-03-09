class Notifier < ActionMailer::Base

  def submit(to_address, subject, params)
    @params = params
    logger.info "PARAMS: #{@params}"
    mail(:to => to_address, :from => params[:email], :subject => subject)
  end
end