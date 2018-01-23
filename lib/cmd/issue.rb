class Issue < ThorBase
  desc "list", "list all issues"
  def list
    list = BmxApiRuby::IssuesApi.new(client)
    output list.get_issues.map {|issue| issue.to_hash}
  end

  desc "show ISSUE_UUID", "show issue details"
  def show(issue_uuid)
    issue = BmxApiRuby::IssuesApi.new(client)
    output issue.get_issues_uuid(issue_uuid).to_hash
  end
end
