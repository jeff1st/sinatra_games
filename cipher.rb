module Cipher

  ALPHA = ("a".."z").to_a
  SPECIALS = [" ", "-", "_", "'", "?", "!", ",", ".", ":", ";", "&"]

  def make_secret(message, key)
    secret = ""
    message.each do |letter|
      SPECIALS.include?(letter) ? secret += letter : secret += key[ALPHA.index(letter)]
    end
    return secret
  end

  def cipher(message, shift)
    secret = ""
    message = message.downcase.split("")
    temp = ALPHA.map { |m| m }
    shift.times do |i|
      temp << temp.delete(temp[0])
    end
    secret = make_secret(message, temp)
  end
end
