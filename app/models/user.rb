class User < ActiveRecord::Base
  before_create :generate_meta_access_token
  before_save :encrypt_password

  validates_presence_of   :username, :github_owner_name, :github_access_token
  validates_presence_of   :password, on: :create
  validates_length_of     :password, minimum: 6, on: :create
  validates_uniqueness_of :meta_access_token

  def self.authenticate(user, password)
    user = User.get
    if user && user.password_hash.eql?(BCrypt::Engine.hash_secret(password, user.password_salt))
      user
    else
      nil
    end
  end

  def self.get
    User.last
  end

  def password
    @password
  end

  def password=(pass)
    @password = pass
  end

  private

    def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end

    def generate_meta_access_token
      begin
        self.meta_access_token = SecureRandom.hex
      end while self.class.exists?(meta_access_token: meta_access_token)
    end

end
