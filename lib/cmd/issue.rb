class Issue < ThorBase
  desc "list", "list all issues"
  option :limit , desc: "limit number of issues" , type: :numeric
  def list
    opts = options[:limit] ? {limit: options[:limit]} : {}
    list = BmxApiRuby::IssuesApi.new(client)
    output(run {list.get_issues(opts).map {|issue| issue.to_hash}})
  end

  desc "show ISSUE_UUID", "show issue details"
  def show(issue_uuid)
    issue  = BmxApiRuby::IssuesApi.new(client)
    output(run { issue.get_issues_issue_uuid(issue_uuid) })
  end
end
