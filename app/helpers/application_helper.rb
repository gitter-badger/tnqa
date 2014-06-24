module ApplicationHelper
  def avatar(user, options = {})
    if user
      link_to image_tag(user.gravatar_url(options)), user
    else
      ""
    end
  end
end
