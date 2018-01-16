require 'thor'

class Repo < Thor
  desc "list", "list all repos"
  def list
    under_construction
  end

  desc "show REPO_UUID", "show repo details"
  def show(_repo_uuid)
    under_construction
  end

  desc "sync REPO_UUID", "sync repo"
  def sync(_repo_uuid)
    under_construction
  end

  desc "close REPO_UUID", "close repo"
  def close(_repo_uuid)
    under_construction
  end
end
