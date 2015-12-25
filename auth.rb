require 'sqlite3'
require 'bcrypt'


def auth(email,pass)
  begin

    db = SQLite3::Database.open ('search.db')

    password = db.prepare 'SELECT Password FROM Access WHERE Email = ?;'
    @user_name = email
    password.bind_param 1, email
    @pass = password.execute.next
    permission = db.prepare 'SELECT Permission FROM Access WHERE Email = ?;'
    permission.bind_param 1, email
    @permission = permission.execute.next
  rescue SQLite3::Exception => e
    puts "Exception occurred"
    puts e
  ensure
    password.close if password
    permission.close if permission
    db.close if db
  end
  if !@pass.nil? and BCrypt::Password.new(@pass[0].to_s) == pass.to_s
    @permission = @permission[0]
    return true
  else
    return false
  end
end

def addUserForm
  return (session[:permission] == 1)
end