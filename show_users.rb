require 'sqlite3'

def showUsers(user_name)

  begin

    db = SQLite3::Database.open ('search.db')

    user_query = db.prepare 'SELECT email FROM access ORDER BY id'
    user_string = user_query.execute
    perm_query = db.prepare 'SELECT permission FROM access ORDER BY id'
    perm_string = perm_query.execute
    bound = (db.get_first_value'SELECT count(*) from access')
    if bound == 0
      return 'There is no users in system!'
    else
      users_array = Array.new(bound) { Array.new(2) }
      (0..bound - 1).each { |item|
        users_array[item][0] = user_string.next.to_s.delete('[').delete(']').delete("\"")
        users_array[item][1] = perm_string.next.to_s.delete('[').delete(']').delete("\"")
      }
    end
  rescue SQLite3::Exception => e
    puts 'Exception occurred'
    puts e
  ensure
    user_query.close if user_query
    perm_query.close if perm_query
    db.close if db
  end
  users_array.compact!
  return users_array

end
