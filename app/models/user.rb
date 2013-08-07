class User < ActiveRecord::Base
  has_many :urls

  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email

   include BCrypt

    def password
      @password ||= Password.new(password_hash)
    end

    def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end

    def self.login(params) 
      @user = User.find_by_email(params[:user][:email])
      if @user.password == params[:user][:password]
        @user
        # session[:user_id] = @user.id
      else
        redirect '/' 
      end
    end

end
