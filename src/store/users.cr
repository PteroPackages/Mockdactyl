module Mockdactyl::Store
  class Users
    @inc : Int32
    @data : Array(User)
    @random : Random

    def initialize
      @inc = 10
      @random = Random.new
      @data = (1..10).map do |id|
        User.new(
          id,
          @random.rand(10) <= 2 ? @random.hex(8) : nil,
          UUID.random.to_s,
          Faker::Internet.user_name,
          Faker::Internet.free_email,
          Faker::Name.first_name,
          Faker::Name.last_name,
          "en",
          @random.next_bool
        )
      end
    end

    def list : Array(User)
      @data
    end

    def index(id : Int32) : User?
      @data.find { |u| u.id == id }
    end

    def index(id : String) : User?
      @data.find { |u| u.external_id == id }
    end

    def create(data : UserCreate) : User
      # TODO: add presence checks

      user = User.new(
        @inc += 1,
        data.external_id,
        UUID.random.to_s,
        data.username,
        data.email,
        data.first_name,
        data.last_name,
        data.language,
        data.root_admin
      )
      @data << user

      user
    end

    def update(user : User, data : UserUpdate) : User
      user.external_id = data.external_id
      user.username = data.username
      user.email = data.email
      user.first_name = data.first_name
      user.last_name = data.last_name

      if value = data.language
        user.language = value
      end

      if value = data.root_admin
        user.root_admin = value
      end

      user
    end
  end
end
