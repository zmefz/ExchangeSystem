class UserResolver

  def self.resolve(user_data)
    @user_data = user_data
    UserResolver.find_user || UserResolver.create_user
  end

  def self.find_user
    UserResolver.find_by_passport || UserResolver.find_by_password
  end

  def self.create_user
    user = User.new(@user_data)
    user.password = @user_data[:password]
    if user.save
      return user
    else
      raise ArgumentError.new(user.errors.full_messages)
    end
  end

  def self.find_by_passport
    User.find_by(passport: @user_data[:passport]) if @user_data[:passport]
  end

  def self.find_by_password
    User.find { |user| user.password == @user_data[:password] } if @user_data[:password]
  end

end
