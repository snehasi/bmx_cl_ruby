require 'thor'

class Issue < Thor
  desc "list", "list all issues"
  def list
    under_construction
  end

  desc "show ISSUE_UUID", "show issue details"
  def show(_issue_uuid)
    under_construction
  end
end
