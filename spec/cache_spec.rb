require 'json'

describe "cache" do
  describe "help" do
    it "returns a value" do
      result = `bmx cache`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "setup" do
    it "default lists" do
      result = `bmx user list`
      result = `bmx repo list`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "list" do
    it "returns a value" do
      result = `bmx cache list`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "show" do
    it "gets a user list" do
      result = `bmx cache show --file=users`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "values" do
    it "gets the Nth uuid" do
      result = `bmx cache value --expression=cached_users_uuid_0`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "gets the first uuid" do
      result = `bmx cache value --expression=cached_users_uuid_first`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "gets the last uuid" do
      result = `bmx cache value --expression=cached_users_uuid_last`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "gets a random uuid" do
      result = `bmx cache value --expression=cached_users_uuid_sample`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end

  describe "UUID-DSL" do
    it "gets the Nth uuid" do
      result = `bmx user show cached_users_uuid_0`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
      expect(result["balance"]).to_not be_nil
    end

    it "gets the first uuid" do
      result = `bmx user show cached_users_uuid_first`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
      expect(result["balance"]).to_not be_nil
    end

    it "gets the last uuid" do
      result = `bmx user show cached_users_uuid_last`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
      expect(result["balance"]).to_not be_nil
    end

    it "gets a random uuid" do
      result = `bmx user show cached_users_uuid_sample`
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
      expect(result["balance"]).to_not be_nil
    end
  end
end
