class Issue < ThorBase
  desc "list", "list all issues"
  option :limit , desc: "limit number of issues" , type: :numeric
  def list
    opts = options[:limit] ? {limit: options[:limit]} : {}
    list = BmxApiRuby::IssuesApi.new(client)
    output(run {list.get_issues(opts).map {|issue| issue.to_hash}})
  end

  desc "show ISSUE_EXID", "show issue details"
  def show(issue_exid)
    issue  = BmxApiRuby::IssuesApi.new(client)
    runput { issue.get_issues_issue_exid(issue_exid, {}) }
  end


  desc "contracts ISSUE_EXID", "show issue contracts"
  def contracts(issue_exid)
    issue  = BmxApiRuby::IssuesApi.new(client)
    output(run {issue.get_issues_issue_exid_contracts(issue_exid).map {|c| c.to_hash}})
  end

  desc "sync ISSUE_EXID", "create or update an issue"
  option :exid       , desc: "TBD" , type: :string
  option :repo_uuid  , desc: "UUID of issue repository" , type: :string
  option :title      , desc: "TBD" , type: :string
  option :status     , desc: "TBD" , type: :string
  option :labels     , desc: "TBD" , type: :string
  def sync(exid)
    opts = {}
    %i(uuid repo_uuid title status labels).each do |lbl|
      opts[lbl] = options[lbl] if options[lbl]
    end
    issue  = BmxApiRuby::IssuesApi.new(client)
    runput { issue.post_issues_exid(exid, opts) }
  end
end


