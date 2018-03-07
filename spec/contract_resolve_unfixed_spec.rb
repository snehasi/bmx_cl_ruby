require 'json'

describe "payout open issue" do
  describe "setup" do
    it "creates test elements" do
      `bmx host rebuild --affirm=destroy_all_data --with_day_offset=-90`
      `bmx user create --usermail=tst1@bugm.net --password=bugm --balance=1000`
      `bmx user create --usermail=tst2@bugm.net --password=bugm --balance=1000`
      repo_uuid = JSON.parse(`bmx repo create BING --type=Test`)["uuid"]
      `bmx issue sync UNFIXED --repo-uuid=#{repo_uuid}`
      expect($?.exitstatus).to eq(0)
    end

    it "creates a fixed offer" do
      issue_uuid = JSON.parse(`bmx issue list`)[0]["uuid"]
      opts = {
        "side"       => "fixed"              ,
        "volume"     => 10                   ,
        "price"      => 0.80                 ,
        "issue"      => issue_uuid           ,
        "userspec"   => "tst1@bugm.net:bugm"
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
        "userspec"   => "tst2@bugm.net:bugm"
      }.map {|k, v| "--#{k}=#{v}"}.join(" ")
      result = `bmx offer create_buy #{opts}`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "makes a cross" do
      offer_uuid = JSON.parse(`bmx offer list --with_type=Buy --with_status=open`).first["uuid"]
      result     = `bmx contract cross #{offer_uuid} --commit-type=expand`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "set issue status to OPEN (UNFIXED)" do
      issue_uuid = JSON.parse(`bmx issue list`)[0]["uuid"]
      result = `bmx issue sync UNFIXED --status=open`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "resets the system date" do
      result = `bmx host set_current_time`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "starts with the right counts" do
      info   = JSON.parse(`bmx host info`)
      counts = JSON.parse(`bmx host counts`)
      expect(info["day_offset"]).to       eq(0)
      expect(counts["users"]).to          eq(3)
      expect(counts["offers_open_bu"]).to eq(0)
      expect(counts["offers_open_bf"]).to eq(0)
      expect(counts["contracts"]).to      eq(1)
      expect(counts["positions"]).to      eq(2)
      expect(counts["events"]).to         eq(21)
    end
  end

  describe "contract resolve" do
    it "starts with the right user balances" do
      users = JSON.parse(`bmx user list`)
      usr1  = users.select {|el| el["email"] == "tst1@bugm.net"}.first
      usr2  = users.select {|el| el["email"] == "tst2@bugm.net"}.first
      expect(usr1["balance"]).to eq(992.0)
      expect(usr2["balance"]).to eq(998.0)
    end

    it "resolves a contract" do
      contract_uuid = JSON.parse(`bmx contract list`).first["uuid"]
      result = JSON.parse(`bmx contract resolve #{contract_uuid}`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "ends with the right counts" do
      info   = JSON.parse(`bmx host info`)
      counts = JSON.parse(`bmx host counts`)
      expect(info["day_offset"]).to       eq(0)
      expect(counts["users"]).to          eq(3)
      expect(counts["offers_open_bu"]).to eq(0)
      expect(counts["offers_open_bf"]).to eq(0)
      expect(counts["contracts"]).to      eq(1)
      expect(counts["contracts_open"]).to eq(0)
      expect(counts["positions"]).to      eq(2)
      expect(counts["events"]).to         eq(25)
    end

    it "ends with the right user balances" do
      users = JSON.parse(`bmx user list`)
      usr1  = users.select {|el| el["email"] == "tst1@bugm.net"}.first
      usr2  = users.select {|el| el["email"] == "tst2@bugm.net"}.first
      expect(usr1["balance"]).to eq(1002.0)
      expect(usr2["balance"]).to eq( 998.0)
    end
  end
end
