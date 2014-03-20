class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :customer_id, :administrator, :first_name, :last_name
  attr_accessor :password
  
  before_save :encrypt_password
  before_create { generate_token(:auth_token) }
  # before_create :generate_unique_id
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  # validates_presence_of :customer_id
  
  def initialize(attributes={})
      super
      self.generate_unique_id
  end
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
    
  
    def generate_unique_id
      begin
        self.u_id = rand(10 ** 11).to_s.rjust(11,'0')
      end while (not User.find_by_u_id(self.u_id).blank?)
      self.barcode_url = ApplicationController.helpers.s3_url + "/" + self.u_id.to_s + ".png"
    end
    
end
