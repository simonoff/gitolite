module Gitolite
  module Constants

    GROUP_PREFIX            = "@"
    REPO_REGEXP             = /^repo (.*)/
    REPO_GIT_CONFIG_REGEXP  = /^config (.+) = ?(.*)/
    PERMS_REGEXP            = /^(-|C|R|RW\+?(?:C?D?|D?C?)) (.* )?= (.+)/
    GROUP_REGEXP            = /^@(\S+) = ?(.*)/
    GITWEB_REGEXP           = /^(\S+)(?: "(.*?)")? = "(.*)"$/
    COMMENTS_REGEXP         = /^((".*?"|[^#"])*)#.*/

  end
end