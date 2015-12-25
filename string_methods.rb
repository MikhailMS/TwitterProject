require 'sqlite3'

def saveString(string)

  begin

    db = SQLite3::Database.open ('search.db')

    db_ok = ((db.get_first_value'SELECT count(*) FROM search_string WHERE string = ?',[string])==0)&&
        ((db.get_first_value'SELECT count(*) FROM search_string WHERE string = ?',[string.downcase])==0)&&
        ((db.get_first_value'SELECT count(*) FROM search_string WHERE string = ?',[string.upcase])==0)&&
        ((db.get_first_value'SELECT count(*) FROM search_string WHERE string = ?',[string.capitalize])==0)

    if db_ok
      url_string = '/custom_search?search='+CGI.escape(string)+'&per_page=10&page=1&sort='
      puts 'String has been saved!'
      db.execute 'INSERT INTO search_string(string, amount, url_string) VALUES (?,1,?)',[string,url_string]
    end
  rescue SQLite3::Exception => e
    puts 'Exception occurred'
    puts e
  ensure
    db.close if db
  end

end

def updateStringCount(string)

  begin

    db = SQLite3::Database.open ('search.db')

    db_ok = ((db.get_first_value'SELECT count(*) FROM search_string WHERE string = ?',[string])==1)
    db_ok_lower = ((db.get_first_value'SELECT count(*) FROM search_string WHERE string = ?',[string.downcase])==1)
    db_ok_up = ((db.get_first_value'SELECT count(*) FROM search_string WHERE string = ?',[string.upcase])==1)
    db_ok_cap = ((db.get_first_value'SELECT count(*) FROM search_string WHERE string = ?',[string.capitalize])==1)

    if db_ok
      count = db.get_first_value'SELECT amount FROM search_string WHERE string = ?',[string]
      puts 'String has been updated!'
      db.execute 'UPDATE search_string SET amount = ? WHERE string = ?',[count+1,string]
    elsif db_ok_lower
      count = db.get_first_value'SELECT amount FROM search_string WHERE string = ?',[string.downcase]
      puts 'String has been updated!'
      db.execute 'UPDATE search_string SET amount = ? WHERE string = ?',[count+1,string.downcase]
    elsif db_ok_up
      count = db.get_first_value'SELECT amount FROM search_string WHERE string = ?',[string.upcase]
      puts 'String has been updated!'
      db.execute 'UPDATE search_string SET amount = ? WHERE string = ?',[count+1,string.upcase]
    elsif db_ok_cap
      count = db.get_first_value'SELECT amount FROM search_string WHERE string = ?',[string.capitalize]
      puts 'String has been updated!'
      db.execute 'UPDATE search_string SET amount = ? WHERE string = ?',[count+1,string.capitalize]
    end
  rescue SQLite3::Exception => e
    puts 'Exception occurred'
    puts e
  ensure
    db.close if db
  end

end

def displayURL

  begin

    db = SQLite3::Database.open ('search.db')

    url_array = Array.new()

    url_query = db.prepare 'SELECT url_string from search_string ORDER by amount DESC'
    string = url_query.execute
    bound = db.get_first_value'SELECT count(*) from search_string'
    if bound >= 10
      bound = 10
    end
    if bound != 0
      (0..bound).each { |item|
        url_array[item] = string.next
        if url_array[item].nil?
          url_array.delete(nil)
        end
      }
    end
  rescue SQLite3::Exception => e
    puts 'Exception occurred'
    puts e
  ensure
    url_query.close if url_query
    db.close if db
  end
  return url_array
end

def displaySearchQuery
  begin

    db = SQLite3::Database.open ('search.db')

    search_array = Array.new()

    search_query = db.prepare 'SELECT string from search_string ORDER by amount DESC'
    string = search_query.execute
    bound = db.get_first_value'SELECT count(*) from search_string'
    if bound >= 10
      bound = 10
    end
    if bound == 0
      search_array[0] = 'There is no recent search query'
    else
      (0..bound).each { |item|
        search_array[item] = string.next
        if search_array[item].nil?
          search_array.delete(nil)
        end
      }
    end
  rescue SQLite3::Exception => e
    puts 'Exception occurred'
    puts e
  ensure
    search_query.close if search_query
    db.close if db
  end
  return search_array
end

def deleteQuery

  begin

    db = SQLite3::Database.open ('search.db')

    db.execute'delete from search_string where amount = 1'

  rescue SQLite3::Exception => e
    puts 'Exception occurred'
    puts e
  ensure
    db.close if db
  end
  puts 'Search query has been deleted!'
end