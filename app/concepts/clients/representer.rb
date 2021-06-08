module Clients
  class Representer
    attr_reader :clients

    def initialize(clients)
      @clients = clients
    end

    def basic
      clients.map do |client|
        {
          id: client.id,
          email: client.email,
          name: client.name,
          age: client.age

        }
      end
    end

    def extended
      clients.map do |_client|
        clients
      end
    end
  end
end
