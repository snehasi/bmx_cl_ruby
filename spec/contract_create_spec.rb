require 'json'

describe "setup" do
  it "creates test elements" do
    `bmx host rebuild --affirm=destroy_all_data`
    expect($?.exitstatus).to eq(0)
  end
end

describe "contract create, clone, series, cancel" do
  it "creates a contract" do
    JSON.parse(`bmx contract create`).first["uuid"]
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end

  it "gets the run contract count" do
    counts = JSON.parse(`bmx host counts`)
    expect(counts["contracts"]).to eq(1)
    expect(counts["events"]).to eq(1)
  end

  it "creates a contract" do
    JSON.parse(`bmx contract create`).first["uuid"]
    expect($?.exitstatus).to eq(0)
    expect(result).to_not be_nil
  end
end
