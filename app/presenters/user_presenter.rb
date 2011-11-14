class UserPresenter < BasePresenter
  presents :user

  def description
    user.description
  end

  def email
    h.link_to user.email, "mailto:#{user.email}" if user.email
  end

  def email_visibility

  end


  def twitter
    h.link_to user.twitter, "http://twitter.com/#{user.twitter}" if user.twitter
  end

  def twitter_visibility
    if user.twitter
      user.twitter_visible? ? '(visible por otrxs colaboradxs)' : '(oculto para otrxs colaboradoxs)'
    end
  end
end

