require 'spec_helper'

describe CouchPublish do
  context "given a document instance that includes CouchPublish" do
        
    describe "#publish!" do
      before do
        @doc = Article.create :title => 'test', :body => 'test test'
      end

      it "should create a milestone" do
        @doc.milestones.length.should == 0
        @doc.publish!
        @doc.milestones.length.should == 1
      end
    end

    describe "#published_versions" do
      before do
        @doc = Article.create :title => 'test', :body => 'test test'
        @doc.publish!
        @doc.title = 'test 2'
        @doc.save
        @doc.title = 'test 3'
        @doc.save
        @doc.publish!
      end

      it "should return all milestones" do
        @doc.published_versions.should == @doc.milestones
      end
    end

    
    describe "#draft?" do
      context "given a new document" do 
        before do
          @doc = Article.create :title => 't', :body => 't' 
        end

        it "should return true" do
          @doc.draft?.should be_true
        end
      end

      context "given a document that was just published" do 
        before do
          @doc = Article.create :title => 't', :body => 't' 
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
          @doc = Article.create :title => 'test', :body => 'test'
          @doc.publish!
        end

        it "should return true" do
          @doc.published?.should be_true
        end
      end

      context "given a document that has never been published" do
        before do
          @doc = Article.create :title => 'test', :body => 'test'
        end

        it "should return false" do
          @doc.published?.should be_false
        end
      end
    end

    describe "#last_published_version" do
      context "given a document that has been published" do
        before do
          @doc = Article.create :title => 'test', :body => 'test'
          @doc.publish!
          @doc.title = 'test 2'
          @doc.save
        end

        it "should return the latest milestone" do
          @doc.last_published_version.should == @doc.milestones.last.instance
        end
      end

      context "given a document that has never been published" do
        before do
          @doc = Article.create :title => 'test', :body => 'test'
        end

        it "should return nil" do
          @doc.last_published_version.should be_nil
        end
      end
    end
    
    describe "#discard_draft!" do
      context "given a document whose current version is published" do
        before do
          @doc = Article.create :title => 'test', :body => 'test'
          @doc.publish!
          @doc.title = 'test 2'
          @doc.save
          @doc.publish!
        end

        it "should raise an exception" do
          proc {@doc.discard_draft!}.should raise_exception("The current version of the document is published. There is no working draft to discard!")
        end
      end

      context "given a document that has never been published" do
        before do
          @doc = Article.create :title => 'test', :body => 'test'
        end

        it "should raise an exception" do
          proc {@doc.discard_draft!}.should raise_exception("This document has never been published. If we discard the current draft, then we'd end up in an existential conundrum.")
        end
      end

      context "given a document whose current version is not published, but has previous published versions" do
        before do
          @doc = Article.create :title => 'test', :body => 'test'
          @doc.publish!
          @doc.title = 'test 2'
          @doc.save
        end

        it "should revert the current document to the previous publish state" do
          @doc.discard_draft!.title.should == "test"
        end

        it "should mark the newly reverted version as published" do
          @doc.discard_draft!.published?.should be_true
        end
      end
    end
    
    describe "#discard_draft" do
      context "given a document whose current version is published" do
        before do
          @doc = Article.create :title => 'test', :body => 'test'
          @doc.publish!
          @doc.title = 'test 2'
          @doc.save
          @doc.publish!
        end

        it "should raise an exception" do
          proc {@doc.discard_draft}.should raise_exception("The current version of the document is published. There is no working draft to discard!")
        end
      end

      context "given a document that has never been published" do
        before do
          @doc = Article.create :title => 'test', :body => 'test'
        end

        it "should raise an exception" do
          proc {@doc.discard_draft}.should raise_exception("This document has never been published. If we discard the current draft, then we'd end up in an existential conundrum.")
        end
      end

      context "given a document whose current version is not published, but has previous published versions" do
        before do
          @doc = Article.create :title => 'test', :body => 'test'
          @doc.publish!
          @doc.title = 'test 2'
          @doc.save
        end

        it "should revert the current document to the previous publish state" do
          @doc.discard_draft.title.should == "test"
        end
      end
    end

  end
end
