class Repo < ThorBase
  desc "list", "list all repos"
  def list
    list = BmxApiRuby::ReposApi.new(client)
    output list.get_repos.map {|repo| repo.to_hash}
  end

  desc "show REPO_UUID", "show repo details"
  def show(repo_uuid)
    repo = BmxApiRuby::ReposApi.new(client)
    output repo.get_repos_uuid(repo_uuid).to_hash
  end

  desc "create NAME", "create repo"
  option :sync, desc: "sync repo on creation", type: :boolean
  def create(repo_name)
    repo = BmxApiRuby::ReposApi.new(client)
    opts = {}
    opts[:sync] = "true" if options[:sync] == true
    output(run {repo.post_repos(repo_name, opts)}.to_hash)
  end

  desc "sync REPO_UUID", "sync repo"
  def sync(_repo_uuid)
    under_construction
  end
end
