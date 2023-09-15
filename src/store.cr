module Mockdactyl::Store
  class_getter users : Array(User) do
    random = Random.new

    (1..10).map do |id|
      arr << User.new(
        id,
        random.rand(10) <= 2 ? random.hex(8) : nil,
        UUID.random.to_s,
        Faker::Internet.user_name,
        Faker::Internet.free_email,
        Faker::Name.first_name,
        Faker::Name.last_name,
        "en",
        random.next_bool
      )
    end
  end

  class_getter api_keys = [] of APIKey
end
