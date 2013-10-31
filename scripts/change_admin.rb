require "./config/environment"
      # desc "Change Thomas.demeo@sweepevents.com to admin not be admin"
      # task :warnings => :environment do
      
      # id_value = 7680004851;
#         scan = Scan.find(12)
#         print "DB VALUE: " + scan.value + "\n"
#         
#         password = '9KumsgtpsleSp!'
#         
#         decrypter = OpenSSL::Cipher::Cipher.new 'AES-128-CBC'
#         decrypter.decrypt
#         decrypter.pkcs5_keyivgen(password)
#       
#         scan.value = decrypter.update(scan.value)
#         scan.value << decrypter.final
#         print "DECRYPT DB VALUE: " + scan.value + "\n"
#           # scan.created_at = nil          
#           # scan.save
#         # end
#       # end
#       # 
      # password = '9KumsgtpsleSp!'
      #     
      # encrypter = OpenSSL::Cipher::Cipher.new 'AES-128-CBC'
      # encrypter.encrypt
      # encrypter.pkcs5_keyivgen password
      #     
      # # self.value = public_key.public_encrypt(self.value)
      # # 
      # id_value = encrypter.update(id_value.to_s)
      # id_value << encrypter.final
      # print "ENCRYPT VALUE: " + id_value + "\n"
#       
#       password = '9KumsgtpsleSp!'
#       
#       
#       decrypter = OpenSSL::Cipher::Cipher.new 'AES-128-CBC'
#       decrypter.decrypt
#       decrypter.pkcs5_keyivgen(password)
#       
#       id_value = decrypter.update(id_value)
#       id_value << decrypter.final
#       print "DECRYPT VALUE: " + id_value + "\n"
# 
      id_value = 768000485;  
      
      password = '9KumsgtpsleSp!'
    
      encrypter = OpenSSL::Cipher::Cipher.new 'AES-128-CBC'
      encrypter.encrypt
      encrypter.pkcs5_keyivgen password
    
      # self.value = public_key.public_encrypt(self.value)
      # 
      id_value = encrypter.update(id_value.to_s)
      id_value << encrypter.final
      print "ENCRYPT VALUE: " + id_value + "\n"
      
      
      scan = Scan.where("value = ?", id_value).all
      print "Number of scans: " + scan.size.to_s
      # print scan.id
        
      
      
      # scan = Scan.find_by_value(id_value)
        # print scan.value.to_s
        
      
      
      # 
      # password = '9KumsgtpsleSp!'
      # private_key = OpenSSL::PKey::RSA.new(File.read(APP_CONFIG['private_key']), password)
      # cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
      # cipher.decrypt
      # cipher.key = private_key.private_decrypt(self.encrypted_key)
      # cipher.iv = private_key.private_decrypt(self.encrypted_iv)
      
      # decrypted_data = cipher.update(self.value)
      # decrypted_data << cipher.final
      # self.encrypted_key = nil
      # self.encrypted_iv = nil
      # scan.value = private_key.private_decrypt(scan.value)
      # print scan.value
      # 
      # 
      # 
      
      # password = '9KumsgtpsleSp!'
 #      
 #      
 #      decrypter = OpenSSL::Cipher::Cipher.new 'AES-128-CBC'
 #      decrypter.decrypt
 #      decrypter.pkcs5_keyivgen(password)
 #      
 #      scan.value = decrypter.update(scan.value)
 #      scan.value << decrypter.final
 #      print scan.value
 
