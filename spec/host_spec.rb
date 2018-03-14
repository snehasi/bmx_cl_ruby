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
      expect(result["users"]).to eq(1)
    end
  end

  describe "rebuild with time offsets" do
    it "returns a value" do
      result = JSON.parse(`bmx host rebuild --affirm=destroy_all_data --with_day_offset=-90`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "generates correct info" do
      result = JSON.parse(`bmx host info`)
      expect(result["day_offset"]).to eq(-90)
      expect(result["hour_offset"]).to eq(0)
    end
  end

  describe "increment day and hour" do
    it "rebuilds from scratch" do
      result = JSON.parse(`bmx host rebuild --affirm=destroy_all_data`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "increments day by one" do
      result = JSON.parse(`bmx host increment_day_offset`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
      result = JSON.parse(`bmx host info`)
      expect(result["day_offset"]).to eq(1)
    end

    it "increments day by ten" do
      result = JSON.parse(`bmx host increment_day_offset --count=10`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
      result = JSON.parse(`bmx host info`)
      expect(result["day_offset"]).to eq(11)
    end

    it "increments hour by one" do
      result = JSON.parse(`bmx host increment_hour_offset`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
      result = JSON.parse(`bmx host info`)
      expect(result["hour_offset"]).to eq(1)
    end

    it "increments hour by ten" do
      result = JSON.parse(`bmx host increment_hour_offset --count=10`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
      result = JSON.parse(`bmx host info`)
      expect(result["hour_offset"]).to eq(11)
    end
  end

  describe "set current time" do
    it "rebuilds in the past" do
      result = JSON.parse(`bmx host rebuild --affirm=destroy_all_data --with_day_offset=-90`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
      result = JSON.parse(`bmx host info`)
      expect(result["day_offset"]).to eq(-90)
    end

    it "sets to current time" do
      result = JSON.parse(`bmx host set_current_time`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
      result = JSON.parse(`bmx host info`)
      expect(result["day_offset"]).to eq(0)
      expect(result["hour_offset"]).to eq(0)
    end
  end

  describe "time jumps" do
    it "goes past end of day" do
      result = JSON.parse(`bmx host go_past_end_of_day`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "goes past end of week" do
      result = JSON.parse(`bmx host go_past_end_of_week`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end

    it "goes past end of month" do
      result = JSON.parse(`bmx host go_past_end_of_month`)
      expect($?.exitstatus).to eq(0)
      expect(result).to_not be_nil
    end
  end
end
