#OpenSSL::SSL::VERIFY_PEER=OpenSSL::SSL::VERIFY_NONE
def twitSort(num)
  case num
    when 1
      unless params[:search].nil?
        @tweets = @client.search(params[:search]).take(@maxTweets)
        @tweets.sort! { |a,b| a.retweet_count <=> b.retweet_count}
      end
    when 2
      unless params[:search].nil?
        @tweets = @client.search(params[:search]).take(@maxTweets)
        @tweets.sort! { |a,b| b.retweet_count <=> a.retweet_count}
      end
    when 3
      unless params[:search].nil?
        @tweets = @client.search(params[:search]).take(@maxTweets)
        @tweets.sort! { |a,b| a.favorite_count <=> b.favorite_count}
      end
    when 4
      unless params[:search].nil?
        @tweets = @client.search(params[:search]).take(@maxTweets)
        @tweets.sort! { |a,b| b.favorite_count <=> a.favorite_count}
      end
    when 5
      unless params[:search].nil?
        @tweets = @client.search(params[:search]).take(@maxTweets)
        @tweets.sort! { |a,b| a.user.screen_name.downcase <=> b.user.screen_name.downcase}
      end
    when 6
      unless params[:search].nil?
        @tweets = @client.search(params[:search]).take(50)
        @tweets.sort! { |a,b| b.user.screen_name.downcase <=> a.user.screen_name.downcase}
      end
  end
end