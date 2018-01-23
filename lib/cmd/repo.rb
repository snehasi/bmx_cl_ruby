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

  desc "sync REPO_UUID", "sync repo"
  def sync(_repo_uuid)
    under_construction
  end
end
