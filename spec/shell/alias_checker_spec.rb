require 'spec_helper'

describe AliasChecker do
  before(:each) do
    alias_file = <<-ZSHHISTORY
ls='ls -G'
logs='nocorrect logs'
mkdir='nocorrect mkdir'
ZSHHISTORY
      file = stub(:read => alias_file)
      File.stub!(:open).and_return(file)
  end

  it "is inialized with a filename" do
    ac = AliasChecker.new("~/.aliases.cache")
    ac.aliases.count.should == 3
  end

  it "doesn't fail if file is missing" do
    AliasChecker.new("file not existant")
  end

  it "can tell you if an alias exists" do
    ac = AliasChecker.new("~/.aliases.cache")
    ac.exist?("ls").should be_true
    ac.exist?("NOT AN ALIAS").should be_false
  end
end
