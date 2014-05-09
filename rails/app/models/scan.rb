class Scan < ActiveRecord::Base
  attr_accessible :event_id, :scanned_at, :value
  validates :value, :presence => true
  validates :value, :numericality => {:only_integer => true}
  validates :event_id, :presence => true
  
  attr_protected :encrypted_key, :encrypted_iv
  before_save :encrypt_value_with_pass
  
  after_find :decrypt_value_with_pass
  
  def self.total_on(departmentID, date)
    where("date(created_at) = ?", date).count
  end
  
  def self.to_csv
    CSV.generate do |csv|
      all.each do |scan|
        csv << [scan.value]
      end
    end
  end
  
  def decrypt_value_with_pass
    if self.has_attribute?(:value)
      password = '9KumsgtpsleSp!'
        
      decrypter = OpenSSL::Cipher::Cipher.new 'AES-128-CBC'
      decrypter.decrypt
      decrypter.pkcs5_keyivgen(password)
    
      self.value = decrypter.update(self.value)
      self.value << decrypter.final
    end
  end
  
  def decrypt_value_with_key
    password = '9KumsgtpsleSp!'
    private_key = OpenSSL::PKey::RSA.new(File.read(APP_CONFIG['private_key']), password)
    self.value = private_key.private_decrypt(self.value)
    
    self.encrypted_key = nil
    self.encrypted_iv = nil
    
  end
  
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
  
  def encrypt_value_with_pass
    if self.value
      password = '9KumsgtpsleSp!'
    
      encrypter = OpenSSL::Cipher::Cipher.new 'AES-128-CBC'
      encrypter.encrypt
      encrypter.pkcs5_keyivgen password
    
      # self.value = public_key.public_encrypt(self.value)
      # 
      self.value = encrypter.update(self.value)
      self.value << encrypter.final
    end
  end
  
  def encrypt_value_with_key
    public_key = OpenSSL::PKey::RSA.new(File.read(APP_CONFIG['public_key']))
    self.value = public_key.public_encrypt(self.value)
    
  end
  
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
