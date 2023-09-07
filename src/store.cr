module Mockdactyl::Store
  class_getter users : Hash(Int32, User) do
    hash = {} of Int32 => User
    random = Random.new

    (1..10).each do |id|
      hash[id] = User.new(
        id,
        UUID.random.to_s,
        Faker::Internet.user_name,
        Faker::Internet.free_email,
        Faker::Name.first_name,
        Faker::Name.last_name,
        "en",
        random.next_bool
      )
    end

    hash
  end

  class_getter api_keys = {} of String => ApiKey
end
