class Scan < ActiveRecord::Base
  attr_accessible :event_id, :scanned_at, :value
  validates :value, :presence => true
  validates :value, :numericality => {:only_integer => true}
  validates :event_id, :presence => true
  
  attr_protected :encrypted_key, :encrypted_iv
  before_save :encrypt_value
  
  after_find :decrypt_value
  
  def decrypt_value
    if self.value
      password = '9KumsgtpsleSp!'
      private_key = OpenSSL::PKey::RSA.new(File.read(APP_CONFIG['private_key']), password)
      cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
      cipher.decrypt
      cipher.key = private_key.private_decrypt(self.encrypted_key)
      cipher.iv = private_key.private_decrypt(self.encrypted_iv)
      
      decrypted_data = cipher.update(self.value)
      decrypted_data << cipher.final
      self.encrypted_key = nil
      self.encrypted_iv = nil
      self.value = decrypted_data
    else
      ''
    end
  end
    
  def clear_sensitive
    self.value = self.encrypted_key = self.encrypted_iv = nil
  end
  
  private
  def encrypt_value
     public_key = OpenSSL::PKey::RSA.new(File.read(APP_CONFIG['public_key']))
     cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
     cipher.encrypt
     cipher.key = random_key = cipher.random_key
     cipher.iv = random_iv = cipher.random_iv
     
     self.value = cipher.update(self.value)
     self.value << cipher.final
     
     self.encrypted_key = public_key.public_encrypt(random_key)
     self.encrypted_iv = public_key.public_encrypt(random_iv) 
  end
end
