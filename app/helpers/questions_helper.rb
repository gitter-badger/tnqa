module QuestionsHelper

  def star_for(object)
    if current_user.voted?(object)
      unvote_for(object)
    else
      vote_for(object)
    end
  end

  private

  def vote_for(object)
    link_to("#{vote_path_for(object)}&up_down=1", remote: true, method: :post) do
      button_tag(class: "btn btn-default") do
        content_tag(:span, '', class: 'glyphicon glyphicon-thumbs-up')
      end
    end +
    link_to("#{vote_path_for(object)}&up_down=-1", remote: true, method: :post) do
      button_tag(class: "btn btn-default") do
        content_tag(:span, '', class: 'glyphicon glyphicon-thumbs-down')
      end
    end
  end

  def unvote_for(object)
    link_to vote_path_for(object), remote: true, method: :delete do
      button_tag(class: "btn btn-danger") do
        content_tag(:span, '', class: 'glyphicon glyphicon-off')
      end
    end
  end

  def vote_path_for(object)
    votes_path(type: object.class.name.underscore, id: object.id).html_safe
  end
end
