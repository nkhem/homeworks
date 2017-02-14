require 'addressable/uri'
require 'rest-client'

def index_users
    url = Addressable::URI.new(
      scheme: 'http',
      host: 'localhost',
      port: 3000,
      path: '/users.html'
    ).to_s

    puts RestClient.get(url)
end

def create_user(name, email)
  begin
    url = Addressable::URI.new(
      scheme: 'http',
      host: 'localhost',
      port: 3000,
      path: '/users.json'
    ).to_s

    puts RestClient.post(
      url,
      { user: { name: name, email: email} }
    )
  rescue => e
    puts "Error: #{e}"
  # retry
  end

end

# index_users
create_user("Gizmo", "gizmo@gizmo.gizmo")
