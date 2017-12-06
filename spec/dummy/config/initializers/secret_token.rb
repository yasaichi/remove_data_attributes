# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
if [Rails::VERSION::MAJOR, Rails::VERSION::MINOR] == [4, 0]
  Dummy::Application.config.secret_key_base = '0db65908e1daf74bce755ce56287dff893f3d7e2139bd6597aca66f0fe161012b9bacb01c8a905912855a6465236e67ac751c56ba103b04f0c1b617d466d5ab8'
end
