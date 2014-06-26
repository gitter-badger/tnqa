module ApplicationHelper
  def avatar(user, options = {})
    if user
      link_to image_tag(user.gravatar_url(options)), user
    else
      ""
    end
  end

  def vote_for(object)
    return "" if current_user.voted?(object)
    link_to(vote_path_for(object), remote: true, method: :post) do
      button_tag(class: "btn btn-default") do
        content_tag(:span, '', class: 'glyphicon glyphicon-thumbs-up')
      end
    end +
    link_to(vote_path_for(object), remote: true, method: :delete) do
      button_tag(class: "btn btn-default") do
        content_tag(:span, '', class: 'glyphicon glyphicon-thumbs-down')
      end
    end
  end

  def favorite_for(object)
    if current_user.favorite?(object)
	    link_to(favorite_path_for(object), remote: true, method: :delete) do
	      button_tag(class: "btn btn-default") do
	        content_tag(:span, '', class: 'glyphicon glyphicon-minus')
	      end
	    end
    else
	    link_to(favorite_path_for(object), remote: true, method: :post) do
	      button_tag(class: "btn btn-default") do
	        content_tag(:span, '', class: 'glyphicon glyphicon-plus')
	      end
	    end
    end
  end

private

  def favorite_path_for(object)
    favorites_path(type: object.class.name.underscore, id: object.id).html_safe
  end

  def vote_path_for(object)
    votes_path(type: object.class.name.underscore, id: object.id).html_safe
  end
end
