# Always sign if possible
# sign_addresses = `gpg --list-keys`.split("\n").grep(/<(.*)>/){$1}
# crypto_selector.set_to :sign_and_encrypt if not sign_addresses.select{|a| header["To"].to_s.include?(a) }.empty?

# Always encrypt if possible
sign_addresses = `gpg --list-keys`.split("\n").grep(/<(.*)>/){$1}
crypto_selector.set_to :sign_and_encrypt if not sign_addresses.select{|a| header["To"].to_s.include?(a) }.empty?
