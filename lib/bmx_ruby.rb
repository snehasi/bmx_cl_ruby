require "rubygems"
require "thor"
require "pry"

require_relative "./bmx_cl_ruby/version"
require_relative "./thor_base"

require_relative "./cmd/config"
require_relative "./cmd/user"
require_relative "./cmd/repo"
require_relative "./cmd/issue"
require_relative "./cmd/offer"
require_relative "./cmd/contract"
require_relative "./cmd/escrow"
require_relative "./cmd/event"

class BmxRuby < Thor
  desc "config SUBCOMMAND ...ARGS", "set BMX host and user credentials"
  subcommand "config", Config

  desc "user SUBCOMMAND ...ARGS", "manage user"
  subcommand "user", User

  desc "repo SUBCOMMAND ...ARGS", "manage repo"
  subcommand "repo", Repo

  desc "issue SUBCOMMAND ...ARGS", "manage issue"
  subcommand "issue", Issue

  desc "offer SUBCOMMAND ...ARGS", "manage offer"
  subcommand "offer", Offer

  desc "contract SUBCOMMAND ...ARGS", "manage contract"
  subcommand "contract", Contract

  desc "escrow SUBCOMMAND ...ARGS", "manage escrow"
  subcommand "escrow", Escrow

  desc "event SUBCOMMAND ...ARGS", "manage event"
  subcommand "event", Event
end


