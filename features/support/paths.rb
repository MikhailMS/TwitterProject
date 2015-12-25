module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /login_page/
      '/login'

      when /the search page/
        '/custom_search'

      when /logout page/
        '/logout'

      when /settings page/
        '/settings'

      when /test search 2nd page/
        '/custom_search?search=test+search&per_page=5&page=2&sort='
      when /test search last page/
        '/custom_search?search=test+search&per_page=5&page=10&sort='



    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"

    end
  end
end

World(NavigationHelpers)
