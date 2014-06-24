module QuestionsHelper

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

private

  def vote_path_for(object)
    votes_path(type: object.class.name.underscore, id: object.id).html_safe
  end
end
