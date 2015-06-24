helpers do

  def current_user
    @current_user ||= begin
      ApiKey.where(key: params[:key]).first.try(:user)
    end
  end

  REQUEST_TIME_FRAME = 2.minutes
  MAX_REQUESTS = 10

  def ensure_authenticated!
    halt(401, 'Unauthorized') if current_user.nil?
    # max 10 requests every 2 minutes
    current_user.request_logs.create!
    if current_user.request_logs.where('created_at >= ?', REQUEST_TIME_FRAME.ago).count > MAX_REQUESTS
      halt(429, 'Too many requests')
    end
  end


end
