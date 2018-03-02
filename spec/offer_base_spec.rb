require 'json'

describe "setup" do
  it "creates test elements" do
    `bmx host rebuild --affirm=destroy_all_data`
    admin_uuid = JSON.parse(`bmx user list`).first["uuid"]
    `bmx user deposit #{admin_uuid} 20000`
    `bmx user create --usermail=tst@bugm.net --password=bugm --balance=10000`
    repo_uuid = JSON.parse(`bmx repo create BING --type=Test`)["uuid"]
    `bmx issue sync IXID --repo-uuid=#{repo_uuid}`
    expect($?.exitstatus).to eq(0)
  end
end

describe "create_buy" do
  it "creates a fixed offer" do
    issue_uuid = JSON.parse(`bmx issue list`)[0]["uuid"]
    opts = {
      "side"       => "fixed"              ,
      "volume"     => 10                   ,
      "price"      => 0.80                 ,
      "issue"      => issue_uuid           ,
      "userspec"   => "tst@bugm.net:bugm"
    }.map {|k, v| "--#{k}=#{v}"}.join(" ")
    cmd = "bmx offer create_buy #{opts}"
    result = `#{cmd}`
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end

  it "creates an unfixed offer" do
    issue_uuid = JSON.parse(`bmx issue list`)[0]["uuid"]
    opts = {
      "side"       => "unfixed"            ,
      "volume"     => 10                   ,
      "price"      => 0.20                 ,
      "issue"      => issue_uuid           ,
      "userspec"   => "tst@bugm.net:bugm"
    }.map {|k, v| "--#{k}=#{v}"}.join(" ")
    result = `bmx offer create_buy #{opts}`
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end

  it "creates another unfixed offer" do
    issue_uuid = JSON.parse(`bmx issue list`)[0]["uuid"]
    opts = {
      "side"       => "unfixed"            ,
      "volume"     => 10                   ,
      "price"      => 0.20                 ,
      "issue"      => issue_uuid           ,
      "userspec"   => "tst@bugm.net:bugm"
    }.map {|k, v| "--#{k}=#{v}"}.join(" ")
    result = `bmx offer create_buy #{opts}`
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end

  it "gets the right count" do
    counts = JSON.parse(`bmx host counts`)
    expect(counts["offers"]).to eq(3)
    expect(counts["offers_open_bu"]).to eq(2)
    expect(counts["offers_open_bf"]).to eq(1)
  end
end

describe "help" do
  it "returns help" do
    result = `bmx offer`
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end
end

describe "checks" do
  it "lists offers" do
    `bmx offer list`
    list = JSON.parse(`bmx offer list`)
    expect($?.exitstatus).to eq(0)
    expect(list).to_not be_nil
    expect(list).to be_an(Array)
  end

  it "shows an offer" do
    offer_uuid = JSON.parse(`bmx offer list`).first["uuid"]
    result = `bmx offer show #{offer_uuid}`
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end
end

describe "clone" do
  it "makes a clone" do
    offer_uuid = JSON.parse(`bmx offer list`).first["uuid"]
    result     = `bmx offer create_clone #{offer_uuid}`
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end

  it "gets the right count" do
    counts = JSON.parse(`bmx host counts`)
    expect(counts["offers"]).to eq(4)
  end
end

describe "counter" do
  it "makes a counter" do
    offer_uuid = JSON.parse(`bmx offer list`).first["uuid"]
    result     = `bmx offer create_counter #{offer_uuid}`
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end

  it "gets the right count" do
    counts = JSON.parse(`bmx host counts`)
    expect(counts["offers_open"]).to eq(5)
  end
end

describe "cancel" do
  it "cancels an offer" do
    offer_uuid = JSON.parse(`bmx offer list`).first["uuid"]
    result     = `bmx offer cancel #{offer_uuid}`
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end

  it "gets the right count" do
    counts = JSON.parse(`bmx host counts`)
    expect(counts["offers"]).to      eq(5)
    expect(counts["offers_open"]).to eq(4)
  end
end


