require 'json'

describe "setup" do
  it "creates test elements" do
    `bmx host rebuild --affirm=destroy_all_data`
    expect($?.exitstatus).to eq(0)
  end
end

describe "contract create, clone, series, cancel" do
  it "creates a contract" do
    result = JSON.parse(`bmx contract create`)
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end

  it "gets the right contract count" do
    counts = JSON.parse(`bmx host counts`)
    expect(counts["contracts"]).to eq(1)
    expect(counts["events"]).to eq(3)
  end

  it "clones the contract" do
    uuid = JSON.parse(`bmx contract list`).first["uuid"]
    expect($?.exitstatus).to eq(0)
    expect(uuid).to_not be_nil
    result = JSON.parse(`bmx contract clone #{uuid}`)
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end

  it "gets the right contract count" do
    counts = JSON.parse(`bmx host counts`)
    expect(counts["contracts"]).to eq(2)
    expect(counts["events"]).to eq(5)
  end

  it "cancels a contract" do
    uuid = JSON.parse(`bmx contract list`).first["uuid"]
    expect($?.exitstatus).to eq(0)
    expect(uuid).to_not be_nil
    result = JSON.parse(`bmx contract cancel #{uuid}`)
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end

  it "gets the right contract count" do
    counts = JSON.parse(`bmx host counts`)
    expect(counts["contracts"]).to eq(1)
    expect(counts["events"]).to eq(7)
  end
end
