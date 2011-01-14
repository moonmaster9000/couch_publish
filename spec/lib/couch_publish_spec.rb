require 'spec_helper'

describe CouchPublish do
  context "given a document instance that includes CouchPublish" do
    before do
      @doc = Article.create :name => 'test', :body => 'test test'
    end
    
    describe "#publish!" do
      it "should call the milestone! method" do
        @doc.should_receive(:milestone!).and_return nil
        @doc.publish!
      end
      
      it "should create a milestone" do
        @doc.milestones.length.should == 0
        @doc.publish!
        @doc.milestones.length.should == 1
      end

      it "should set draft to false"
    end
    
    describe "#draft?" do
      context "given a new document" do 
        before do
          @doc = Article.new :name => 't', :body => 't' 
        end

        it "should return true" do
          @doc.draft?.should be_true
        end
      end

      context "given a document that was just published" do 
        before do
          @doc = Article.create :name => 't', :body => 't' 
          @doc.publish!
        end

        it "should return false" do
          @doc.draft?.should be_false
        end
      end

    end

    describe "#published?" do
      context "given a document that has been published" do
        before do
          @doc = Article.create :name => 'test', :body => 'test'
          @doc.publish!
        end

        it "should return true" do
          @doc.published?.should be_true
        end
      end

      context "given a document that has never been published" do
        before do
          @doc = Article.create :name => 'test', :body => 'test'
        end

        it "should return false" do
          @doc.published?.should be_false
        end
      end
    end
  end
end
