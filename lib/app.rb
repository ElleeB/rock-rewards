module App

  @@app_id = 0

  CHARS = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a

  # new clients assigned an id
  def assign_client_id
    @@app_id += 1
    self.account_id = @@app_id
  end

  # generate a new key
  def self.gen_key(length=10)
    CHARS.sort_by { rand }.join[0...length]
  end

  # assign the key
  def assign_key
    key = App.gen_key
    self.secret_key = key
  end
end
