require 'digest/md5'

module Gravatar
  def avatar_url(size = 100)
    digest = Digest::MD5.hexdigest(email)
    "http://gravatar.com/avatar/#{digest}?s=#{size}"
  end
end
