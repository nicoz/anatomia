# @author Nicolas Zuasti
class User < ActiveRecord::Base
  # Accessible attributes for mass asignment
  attr_accessible :email, :password, :password_confirmation

  # Virtual attribute for GUI interaccion,
  # the real data is stored in password_salt and password_hash
  # @return [String]
  attr_accessor :password

  # Before saving the object the method encrypt_password is executed
  before_save :encrypt_password
  
  # Validating password presence
  validates :password, :presence =>  {:on => :create}

  # Using Rails password confirmation tools
  validates_confirmation_of :password
  
  # Validating :email's presence, format and uniqueness
  validates :email, :presence => true, :uniqueness => true,  :email => true
  
  # Uses the BCrypt module to generate the encription for the password
  # storing the result in both password_salt and password_hash
  # @return [String, nil] Returns the encripted password if the attribute password 
  # is present in this instance.
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  # Searches the user by it's email. If the User exists the system checks
  # its password against the one entered via GUI. If they match the 
  # instance is returned
  # @return [User, nil] Instance of the User class if the email and password matches, else nil.
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
end
