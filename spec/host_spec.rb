require 'json'

describe "host" do
  describe "help" do
    it "returns a value" do
      result = `bmx host`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "info" do
    it "returns a value" do
      result = JSON.parse(`bmx host info`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "ping" do
    it "returns a value" do
      result = JSON.parse(`bmx host ping`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "counts" do
    it "returns a value" do
      result = JSON.parse(`bmx host counts`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "next_week_ends" do
    it "returns a value" do
      result = JSON.parse(`bmx host next_week_ends`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "rebuild" do
    it "returns a value" do
      result = JSON.parse(`bmx host rebuild --affirm=destroy_all_data`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "generates correct counts" do
      result = JSON.parse(`bmx host counts`)
      expect(result["num_users"]).to eq(1)
    end
  end
end
