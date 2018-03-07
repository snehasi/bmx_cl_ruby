require 'json'
require 'pry'

describe "setup" do
  it "creates test elements" do
    `bmx host rebuild --affirm=destroy_all_data`
    `bmx user create --usermail=tst@bugm.net --password=bugm --balance=1000`
    repo_uuid = JSON.parse(`bmx repo create BING`)["uuid"]
    binding.pry
    result    = JSON.parse(`bmx issue sync IXID --repo-uuid=#{repo_uuid}`)
    binding.pry
    repo      = JSON.parse(`bmx repo show #{repo_uuid}`)
    binding.pry
    expect($?.exitstatus).to eq(0)
    expect(repo["issue_count"]).to eq(1)
  end
end

describe "offer" do
  describe "help" do
    it "returns help" do
      result = `bmx offer`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "list" do
    it "returns a value" do
      result = `bmx offer list`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
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
      result = `bmx offer create_buy #{opts}`
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
      expect(counts["offers_open_bu"]).to eq(2)
      expect(counts["offers_open_bf"]).to eq(1)
    end

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
end

describe "contract" do
  describe "help" do
    it "returns help" do
      result = `bmx contract`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "cross" do
    it "makes a cross" do
      offer_uuid = JSON.parse(`bmx offer list`).first["uuid"]
      result     = `bmx contract cross #{offer_uuid} --commit-type=expand`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "gets the right count" do
      counts = JSON.parse(`bmx host counts`)
      expect(counts["contracts"]).to eq(1)
    end
  end

  describe "list" do
    it "returns a value" do
      result = JSON.parse(`bmx contract list`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
      expect(result.length).to eq(1)
    end
  end

  describe "show" do
    it "shows a contract" do
      contract_uuid = JSON.parse(`bmx contract list`).first["uuid"]
      result = JSON.parse(`bmx contract show #{contract_uuid}`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "escrows" do
    it "shows contract escrows" do
      contract_uuid = JSON.parse(`bmx contract list`).first["uuid"]
      result = JSON.parse(`bmx contract escrows #{contract_uuid}`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "open_offers" do
    it "shows contract open_offers" do
      contract_uuid = JSON.parse(`bmx contract list`).first["uuid"]
      result = JSON.parse(`bmx contract open_offers #{contract_uuid}`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end
end
