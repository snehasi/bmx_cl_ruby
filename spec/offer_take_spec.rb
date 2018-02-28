require 'json'

WORKER="worker@bugm.net"

describe "setup" do
  it "creates test elements" do
    `bmx host rebuild --affirm=destroy_all_data --with_day_offset=-90`
    `bmx user list`
    `bmx user deposit cached_users_uuid_first 1000`
    `bmx user create --usermail=#{WORKER} --balance=1000`
    `bmx repo create BING`
    `bmx repo list`
    `bmx issue sync IXID --repo-uuid=cached_repos_uuid_first`
    expect($?.exitstatus).to eq(0)
  end

  it "has the right counts" do
    result = JSON.parse(`bmx host counts`)
    expect(result["num_users"]).to eq(2)
    expect(result["num_repos"]).to eq(1)
    expect(result["num_issues"]).to eq(1)
  end
end

describe "create_buy" do
  it "creates a fixed offer" do
    `bmx issue list`
    opts = {
      "side"     => "fixed"                       ,
      "volume"   => 10                            ,
      "price"    => 0.80                          ,
      "issue"    => "cached_issues_uuid_first"    ,
      "userspec" => "#{WORKER}:bugpass"
    }.map {|k, v| "--#{k}=#{v}"}.join(" ")
    result = `bmx offer create_buy #{opts}`
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end
end

describe "take" do
  it "has the right user balances" do
    `bmx user list`
    res1 = `bmx cache value --expression=cached_users_balance_first`
    expect(res1.chomp).to eq("1000.0")
    res2 = `bmx cache value --expression=cached_users_balance_last`
    expect(res2.chomp).to eq("1000.0")
  end

  it "takes an offer" do
    `bmx offer list`
    result = `bmx offer take cached_offers_uuid_first`
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end

  it "gets the right count" do
    counts = JSON.parse(`bmx host counts`)
    expect(counts["contracts"]).to eq(1)
    expect(counts["offers"]).to eq(0)
  end

  it "has the right user balances" do
    `bmx user list --with-email=admin --cache-file=admin`
    res1 = `bmx cache value --expression=cached_admin_balance_first`
    expect(res1.chomp).to eq("998.0")
    `bmx user list --with-email=worker --cache-file=worker`
    res2 = `bmx cache value --expression=cached_worker_balance_last`
    expect(res2.chomp).to eq("992.0")
  end
end

describe "resolve" do
  it "resolves a contract" do
    `bmx contract list`
    `bmx host set_current_time`
    result = `bmx contract resolve cached_contracts_uuid_first`
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end

  it "gets the right count" do
    counts = JSON.parse(`bmx host counts`)
    expect(counts["contracts"]).to eq(0)
  end

  it "has the right user balances" do
    `bmx user list --with-email=admin --cache-file=admin`
    res1 = `bmx cache value --expression=cached_admin_balance_first`
    expect(res1.chomp).to eq("1008.0")
    `bmx user list --with-email=worker --cache-file=worker`
    res2 = `bmx cache value --expression=cached_worker_balance_last`
    expect(res2.chomp).to eq("992.0")
  end
end
