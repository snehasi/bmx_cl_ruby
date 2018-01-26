require "rubygems"
require "thor"

require_relative "./bmx_cl_ruby/version"
require_relative "./thor_base"

require_relative "./cmd/config"
require_relative "./cmd/user"
require_relative "./cmd/repo"
require_relative "./cmd/issue"
require_relative "./cmd/offer"
require_relative "./cmd/contract"
require_relative "./cmd/escrow"
require_relative "./cmd/position"
require_relative "./cmd/event"
require_relative "./cmd/bmx_time"

class BmxRuby < Thor
  desc "config SUBCOMMAND", "set BMX host and user credentials"
  subcommand "config", Config

  desc "user SUBCOMMAND", "manage user"
  subcommand "user", User

  desc "repo SUBCOMMAND", "manage repo"
  subcommand "repo", Repo

  desc "issue SUBCOMMAND", "manage issue"
  subcommand "issue", Issue

  desc "offer SUBCOMMAND", "manage offer"
  subcommand "offer", Offer

  desc "contract SUBCOMMAND", "manage contract"
  subcommand "contract", Contract

  desc "position SUBCOMMAND", "manage position"
  subcommand "position", Position

  desc "escrow SUBCOMMAND", "manage escrow"
  subcommand "escrow", Escrow

  desc "event SUBCOMMAND", "manage event"
  subcommand "event", Event

  desc "time SUBCOMMAND", "manage time"
  subcommand "time", BmxTime
end


