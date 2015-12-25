require 'timers'

def autoFollow
  @potentialUsers = Hash.new()
  timers = Timers::Group.new

  auto_timer = timers.every(7200)
    file = File.open('lastID.txt', 'r')
    last = file.read
    file.close

    @most_recent = @client.search('Company Name').take(50)
    first = true
    newLast = ''

    @most_recent.each do |tweet|

      if first
        newLast = tweet.id
        first = false
      end

      if tweet.id.to_s == last.to_s
        auto_timer.cancel
      end

      @user = @client.status(tweet.id).user
      if (@potentialUsers[@user] == nil)
        @potentialUsers[@user] = 0
      end
      @potentialUsers[@user] = @potentialUsers[@user] + 1
      if @potentialUsers[@user] == 3
        @client.follow(@user)
      end
    end

    file = File.open('lastID.txt', 'w')
    file.print newLast
    file.close

  loop { timers.wait }
end