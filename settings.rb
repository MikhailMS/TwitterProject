require 'sqlite3'
require 'bcrypt'
require 'execjs'
require 'v8'

def changePassword(oldPass,newPass,newPass2)

  #Getting input to change password
  newPassword = newPass.strip.to_s
  newPassword2 = newPass2.strip.to_s
  oldPassword = oldPass.strip.to_s
  begin

    db = SQLite3::Database.open ('search.db')

    #Validating input for new password
    db_pass = db.get_first_value 'SELECT Password FROM Access WHERE Email = ?;',[session[:username]]
    puts "Value: #{db_pass}"
    db_match = BCrypt::Password.new(db_pass)==oldPassword
    oldPassword_ok = oldPassword != '' && !oldPassword.nil?
    newPassword_ok = newPassword != '' && !newPassword.nil? && newPassword.length >= 6
    newPassword2_ok = newPassword==newPassword2

    if oldPassword_ok&&newPassword_ok&&newPassword2_ok&&db_match
      @success = 'Your password has been successfully changed'
      db.execute "UPDATE access set password = ? where email=?",[BCrypt::Password.create(newPassword),session[:username]]
    elsif !db_match
      @error='Your old password is not correct'
    elsif !oldPassword_ok
      @error = "You've typed incorrect password"
    elsif !newPassword_ok
      @error = 'New password must be at least 6 symbols long!'
    elsif !newPassword2_ok
      @error = "Your new password doesn't match itself in one of the fields."
    end
  rescue SQLite3::Exception => e
    puts 'Exception occurred'
    puts e
  ensure
    db.close if db
  end
end

def addUser(name,password)
  #Getting input for new user
  accountName = name.strip.to_s
  accountPassword = password.strip.to_s
  begin
    db = SQLite3::Database.open ('search.db')
    #Validating input for new user
    name_ok = !accountName.nil? && accountName != ""
    pass_ok = !accountPassword.nil? && accountPassword !="" && accountPassword.length >=6
    db_ok = (db.get_first_value 'SELECT count(*) FROM Access WHERE Email = ?',[accountName]) == 0

    if db_ok&&name_ok&&pass_ok
      @success = 'New account has been created'
      db.execute 'INSERT INTO Access(Email, Password, Permission) VALUES (?,?,0)',[accountName,BCrypt::Password.create(accountPassword)]
    elsif !pass_ok
      @error = 'Passwords must be at least 6 characters long'
    else
      @error = 'This name is already taken'
    end
  rescue SQLite3::Exception => e
    puts 'Exception occurred'
    puts e
  ensure
    db.close if db
  end
end

def changePermission(user, perm)
  begin
    db = SQLite3::Database.open ('search.db')
    db_ok = (db.get_first_value 'SELECT count(*) FROM Access WHERE Email = ?', user) == 1
    if db_ok
      if perm == 'User'
        db.execute 'UPDATE Access SET Permission = 0 WHERE Email = ?', user
      else
        db.execute 'UPDATE Access SET Permission = 1 WHERE Email = ?', user
      end
      @success = 'User permission updated'
    else
      @error = 'User does not exist'
    end
  rescue SQLite3::Exception => e
    puts 'Exception occurred'
    puts e
  ensure
    db.close if db
  end
end

def clearSearches()
  begin
    db = SQLite3::Database.open ('search.db')
    db.execute 'DELETE FROM search_string;'
    db.execute 'DELETE FROM sqlite_sequence WHERE name = ?;', 'search_string'
    @success = 'All searches deleted'
  rescue SQLite3::Exception => e
    puts 'Exception occurred'
    puts e
  ensure
    db.close if db
  end
end

def deleteUsers(user_name)

  begin
    puts "Delete user #{user_name}"
    db = SQLite3::Database.open ('search.db')

    if(user_name==session[:username])
      @error = "You cannot delete the current account!"
    else
      if ((db.get_first_value'select count(*) from access where email = ?', user_name) == 1)
        puts "Deleting #{user_name}"
        #db.execute 'delete from access where email = ?', user_name
        @success = "You successfully deleted user: #{user_name}."
      else
        @error = "User does not exist."
      end
    end
  rescue SQLite3::Exception => e
    puts 'Exception occurred'
    puts e
  ensure
    db.close if db
  end

end
