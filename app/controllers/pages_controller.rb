class PagesController < ApplicationController
  def impressum
  end

  def privacy
  end

  def contact
    authenticate_user!
  end

  def about
  end

  def flashs
    {
      info: "Wow, info",
      success: "wow, success!",
      notice: 'Here, a notice!',
      other: 'something else',
      danger: 'something dangereous (danger)',
      error: 'Oooups, error!',
      warning: 'Careful, warning',
      alert: 'Careful, alert',
      failure: 'there was a failure',
    }.each {|k,v| helpers.add_flash(k => v)}
  end
end
