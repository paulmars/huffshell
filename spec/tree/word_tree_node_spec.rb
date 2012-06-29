require 'spec_helper'

describe WordTreeNode do
  it "can be created as a root node" do
    WordTreeNode.new.should be_root
  end

  it "can be created with a word" do
    node = WordTreeNode.new("git")
    node.should_not be_root
    node.word.should == "git"
  end

  it "ugly words can be used and cleaned" do
    node = WordTreeNode.new("-m")
    node.word.should == "-m"
    node.cleanword.should == "m"
  end

  it "can be a pile |" do
    node = WordTreeNode.new("|")
    node.word.should == "|"
    node.cleanword.should == "|"
  end

  it "can be a ." do
    node = WordTreeNode.new(".")
    node.word.should == "."
    node.cleanword.should == "."
  end

  it "is comparable" do
    node1 = WordTreeNode.new("git")
    node1.add(ScriptLine.new("git blame"))

    node2 = WordTreeNode.new("ls")
    (node1 <=> node2).should == -1

    node2.add(ScriptLine.new("ls -l"))
    (node1 <=> node2).should == 0

    node2.add(ScriptLine.new("ls -G"))
    (node1 <=> node2).should == 1
  end

  context "with lines" do
    before :each do
      @node = WordTreeNode.new
      @sl1 = ScriptLine.new("git status")
      @sl2 = ScriptLine.new("git blame")
      @sl3 = ScriptLine.new("ls")

      @node.add(@sl1)
      @node.add(@sl2)
      @node.add(@sl3)
    end

    it "has two nodes" do
      @node.words.sort.should == ["git", "ls"].sort
    end

    it "says it has 3 lines" do
      @node.line_count.should == 3
    end

    it "is level 0 and children are level 2" do
      @node.level.should == 0
      @node.children["git"].level.should == 1
    end

    it "retains the parent node" do
      @node.children["git"].parent.should == @node
    end

    it "can truncate to a minimum count" do
      @node.truncate!(2)
      @node.children["ls"].should be_nil
      @node.words.should == ["git"]
    end

    context "with many children" do
      before :each do
        @node.add(ScriptLine.new("git add Readme"))
        @node.add(ScriptLine.new("git add Rakefile"))
        @node.add(ScriptLine.new("git add index"))
      end

      it "truncates chilren as well" do
        @node.truncate!(3)
        @node.children["git"].children["add"].should_not be_nil
        @node.children["git"].children["add"].line_count.should == 3
      end
    end
  end

  context "when printing" do
    before(:each) do
      @node = WordTreeNode.new
      @node.add(ScriptLine.new("git"))
    end

    it "shows no lines, children show lines" do
      @node.to_tree.should == ""
    end

    it "shows the count" do
      @node.children["git"].to_tree.should == "\e[0;32;49mgit\e[0m 1:\n"
    end

    it "shows two lines" do
      @node.add(ScriptLine.new("ls"))
      @node.children["git"].to_tree.should == "\e[0;32;49mgit\e[0m 1:\n"
      @node.children["ls"].to_tree.should == "\e[0;32;49mls\e[0m 1:\n"
    end

    it "shows indentation" do
      @node.add(ScriptLine.new("git commit -m 'test'"))
      @node.add(ScriptLine.new("git commit -m 'bogart'"))
      @node.children["git"].children["commit"].to_tree.should ==
        "  \e[0;32;49mcommit\e[0m 2:\n"
    end

    it "shows full block" do
      @node.add(ScriptLine.new("git commit -m 'test'"))
      @node.add(ScriptLine.new("git commit -m 'bogart'"))
      @node.children["git"].to_tree.should == "\e[0;32;49mgit\e[0m 3:\n"
    end
  end

  context "creating a list of commands" do
    it "returns an array" do
      @node = WordTreeNode.new

      @node.add(ScriptLine.new("git commit"))
      @node.children["git"].children["commit"].word_list.should == ["git", "commit"]
    end
  end

end
