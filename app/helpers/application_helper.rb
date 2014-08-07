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
end
