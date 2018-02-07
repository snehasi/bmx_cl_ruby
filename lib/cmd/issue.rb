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
    runput { issue.get_issues_issue_uuid(issue_uuid, opts) }
  end

  desc "sync ISSUE_EXID", "create or update an issue"
  option :type       , desc: "TBD"    , type: :string
  option :uuid       , desc: "TBD"    , type: :string
  option :repo_uuid  , desc: "TBD"    , type: :string
  option :issue_uuid , desc: "TBD"    , type: :string
  option :title      , desc: "TBD"    , type: :string
  option :status     , desc: "TBD"    , type: :string
  option :labels     , desc: "TBD"    , type: :string
  def sync(exid)
    opts = {}
    %i(type uuid repo_uuid issue_uuid title status labels).each do |lbl|
      opts[lbl] = options[lbl] if options[lbl]
    end
    issue  = BmxApiRuby::IssuesApi.new(client)
    runput { issue.post_issues_exid(exid, opts) }
  end
end


