require 'twitter'
require 'erb'
require 'sinatra'
require 'thread'
require 'execjs'
require 'v8'

load 'sort_methods.rb'
load 'auth.rb'
load 'settings.rb'
load 'string_methods.rb'
load 'show_users.rb'
load 'auto_follow.rb'       
load 'unfollow.rb'          


include ERB::Util
#OpenSSL::SSL::VERIFY_PEER=OpenSSL::SSL::VERIFY_NONE
set :server, 'thin'
enable :sessions
set :session_secret, 'super secret'
@@pageNum = 1

before do
  config = {
      :consumer_key => 'BvoXJ2m6C4j7LPCvcMNs0ztS4',
      :consumer_secret => 'Ok88Qes4sfyRodYTGSTI6nJnq4I5BwILaZ33fRdzMY99v3kDxI',
      :access_token => '2878269533-JseUwCF1Aujjlc5o9u7mMxwHDdmXdckxpZp6RYm',
      :access_token_secret => 'z4nObvsySdSo1I7ouebLaITL7QJuGHkMOuGuEzGkEoQan'
  }
  @client = Twitter::REST::Client.new(config)
  @maxTweets = 50

end

get '/' do
  unless session[:logged_in]
    redirect '/login'
  end
  erb  :login2
end

get '/login' do
  #the auto_follow and unfollow methods are called using threads
  t1 = Thread.new{autoFollow}
  t2 = Thread.new{unfollow}
  t1.join
  t2.join

  erb :login2
end

#Log-in system
post '/login' do
  if auth(params[:email],params[:password])
    #@user_name[0] = @user_name[0].upcase
    puts "You've logged in as #{@user_name}"
    session[:username] = @user_name
    session[:permission] = @permission
    session[:logged_in] = true
    session[:login_time] = Time.now
    puts "Permission: #{session[:permission]}"
    puts session[:login_time]
    redirect '/homepage'
  end
  @error = 'Incorrect email or password'
  erb :login2
end

get '/homepage' do
  unless session[:logged_in]
    redirect '/login'
  end
  @user = session[:username]
  puts "User: #{@user}"
  @urls = displayURL
  @strings = displaySearchQuery
  @users = Array.new()
  if(session[:permission] == 1)
    @users = showUsers(session[:username])
  end
  erb  :homepage
end

#Activating the form to add new user to system.
post '/addAcc' do
  unless session[:logged_in]
    redirect '/login'
  end
  addUser(params[:accountName],params[:accountPassword])
  @user = session[:username]
  erb :settings
end

#Activating a form to change a password for a user.
post '/chPass' do
  unless session[:logged_in]
    redirect '/login'
  end
  changePassword(params[:passOld],params[:passNew],params[:passNew2])
  @user = session[:username]
  erb :settings
end

#Updating permissions
post '/updatePermission' do
  unless session[:logged_in]
    redirect '/login'
  end
  changePermission(params[:accountName_Per], params[:accountPermission])
  @user = session[:username]
  erb :settings
end

#Clear search strings
post '/clearSearches' do
  unless session[:logged_in]
    redirect '/login'
  end
  clearSearches()
  @user = session[:username]
  erb :settings
end

#Delete user from system
post '/deleteUser' do
  unless session[:logged_in]
    redirect '/login'
  end
  puts "Value in delete method is #{params[:userToDelete]}"
  deleteUsers(params[:userToDelete])
  @user = session[:username]
  erb :settings
end

get '/settings' do
  unless session[:logged_in]
    redirect '/login'
  end
  @user = session[:username]
  erb :settings
  #redirect '/homepage'
end

#Standard search

get '/custom_search' do
  unless session[:logged_in]
    redirect '/login'
  end
  unless params[:search].nil?
    if params[:search].empty?
      @error = 'There is no search query'
    else
      updateStringCount(params[:search])
      saveString(params[:search])

      #if the page isn't in range, go to the next nearest
      unless params[:page].nil?
        if params[:page].to_i < 1
          params[:page] = "1"
        elsif params[:page].to_f > (@maxTweets / params[:per_page].to_f).ceil
          params[:page] = (@maxTweets / params[:per_page].to_i)
        end
      end

      #changed sorting so that it uses a value submitted from the form, rather than its own URL
      if params[:sort].to_i > 0 && params[:sort].to_i < 7
        twitSort(params[:sort].to_i)
      else
        @tweets = @client.search(params[:search]).take(@maxTweets)
      end

    end
  end
  erb :custom_search
end

get '/followers' do
  unless session[:logged_in]
    redirect '/login'
  end
  @followers = @client.followers()
  erb :followers
end

get '/logout' do
  unless session[:logged_in]
    redirect '/login'
  end
  session.clear
  puts session[:logout]
  deleteQuery
  erb :logout
end

#Standard error saying go to the page we actually want
not_found do
  redirect '/login' unless session[:logged_in]
  erb :page_not_found
end