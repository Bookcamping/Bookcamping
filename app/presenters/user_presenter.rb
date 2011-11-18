class UserPresenter < BasePresenter
  presents :user

  def show_private?
    @options[:show_private]
  end

  def header
    h.render partial: 'shared/users/header', locals: {presenter: self}
  end

  def count
    @options[:count] if @options[:count]
  end


  def description
    user.description
  end

  def email
    h.link_to user.email, "mailto:#{user.email}" if user.email
  end

  def email_visibility

  end


  def twitter
    h.link_to "@#{user.twitter}", "http://twitter.com/#{user.twitter}", target: '_blank' if user.twitter
  end

  def twitter_visibility
    if user.twitter
      user.twitter_visible? ? '(visible por otrxs colaboradxs)' : '(oculto para otrxs colaboradoxs)'
    end
  end
end

