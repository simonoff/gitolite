module Gitolite
  class Config
    #Represents a repo inside the gitolite configuration.  The name, permissions, and git config
    #options are all encapsulated in this class
    class Repo
      ALLOWED_PERMISSIONS = ['C', 'R', 'RW', 'RW+', 'RWC', 'RW+C', 'RWD', 'RW+D', 'RWCD', 'RW+CD', '-']

      attr_accessor :permissions, :name, :config, :owner, :description

      def initialize(name)
        @name = name
        #Store the perm hash in a lambda since we have to create a new one on every deny rule
        @perm_hash_lambda = lambda { Hash.new {|k,v| k[v] = Hash.new{|k2, v2| k2[v2] = [] }} }
        @permissions = Array.new.push(@perm_hash_lambda.call)
        @config = {}
      end

      def clean_permissions
        @permissions = Array.new.push(@perm_hash_lambda.call)
      end

      def add_permission(perm, refex = "", *users)
        if ALLOWED_PERMISSIONS.include? perm
          #Handle deny rules
          if perm == '-'
            @permissions.push(@perm_hash_lambda.call)
          end

          @permissions.last[perm][refex].concat users.flatten
          @permissions.last[perm][refex].uniq!
        else
          raise InvalidPermissionError, "#{perm} is not in the allowed list of permissions!"
        end
      end

      def set_git_config(key, value)
        @config[key] = value
      end

      def unset_git_config(key)
        @config.delete(key)
      end

      def to_s
        repo = "repo    #{@name}\n"

        @permissions.each do |perm_hash|
          perm_hash.each do |perm, list|
            list.each do |refex, users|
              repo += "  " + perm.ljust(6) + refex.ljust(25) + "= " + users.join(' ') + "\n"
            end
          end
        end

        @config.each do |k, v|
          repo += "  config " + k + " = " + v + "\n"
        end

        repo
      end

      def gitweb_description
        if @description.nil?
          nil
        else
          desc = "#{@name} "
          desc << '"' + @owner + '" ' unless @owner.nil?
          desc << '= "' + @description + '"'
        end
      end

      #Gets raised if a permission that isn't in the allowed
      #list is passed in
      class InvalidPermissionError < ArgumentError
      end
    end
  end
end
