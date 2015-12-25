def unfollow
  while (true)
    sleep(900)
    @following = @client.friends()
    i = 1

    @following.each do |friend|

      @tweets = @client.user_timeline(friend)
      @most_recent = @tweets.take(50)
      unf = true

      @most_recent.each do |tweet|
        if tweet.text.include? 'Company Name'
          unf = false
          break
        end
      end

      if unf
        @client.unfollow(friend)
      end

      if (i%3 == 0)
        sleep(900)
      end
      i = i+1
    end
    sleep(7200)
  end
end