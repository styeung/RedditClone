module ApplicationHelper

  def auth_token
    <<-HTML.html_safe
      <input type="hidden"
      name="authenticity_token"
      value="#{form_authenticity_token}">
    HTML
  end

  def standard_in_out_prompt
    if signed_in?
      <<-HTML.html_safe
        You are signed in as #{h(current_user.username)}.
        #{ button_to("Sign Out", session_url, method: :delete) }
      HTML
    else
      <<-HTML.html_safe
        You are not signed in.
        #{ button_to("Sign In", new_session_url, method: :get) }
      HTML
    end
  end

  def vote_buttons(voteable)
    if voteable.has_voted?(current_user)
      button_to("Rescind Vote", vote_url(voteable.get_vote(current_user)), method: :delete)
    else
      path = voteable.class == Post ? post_votes_url(voteable.id) : comment_votes_url(voteable.id)

      <<-HTML.html_safe
        <form action="#{path}" method="POST">
          <input type="hidden" name="value" value="1">
          <button>Upvote</button>
        </form>
        <form action="#{path}" method="POST">
          <input type="hidden" name="value" value="-1">
          <button>Downvote</button>
        </form>
      HTML
    end
  end
end
