require 'spec_helper'

describe BinaryChecker do
  context "accepts a command" do
    it "knows that 'ls' _probably_ exists" do
      BinaryChecker.new("ls").should be_exist
    end

    it "knows that 'boooganone' _probably_ doesn't exists" do
      BinaryChecker.new("boooganone").should_not be_exist
    end
  end
end
