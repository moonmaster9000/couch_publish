# Introduction

Powerful, easy-to-use publishing logic, for couchdb documents. Relies on the `memories` gem for versioning. 

## Installation

This be a gem. Install it.

    # gem install couch_publish

Then, include `CouchPublish` in your `CouchRest::Model::Base` derived classes.

    class Article < CouchRest::Model::Base
      include CouchPublish

      property :title
      property :author
      property :body
    end
## Publishing

Wanna publish a document? Awesome. There's a `publish!` method. First, save your document, then `publish!` it!
  
    @article = Article.create :title => 'Publishing made simple!', :author => 'moonmaster9000', :body => 'CouchPublish makes publishing simple'
    @article.publish!

Wanna know if the current version of your document is published? Simple!

    @article.published? #==> true, since the current version is published

## Drafts

So you've published a document. Now you want to make some more changes, but your not ready to publish those. Simple!

    @article.title = 'Publishing gets simpler'
    @article.save
    @article.draft? #==> true
    @article.previously_published? # ==> true

## Drafts are cool, but how do I go back to the published version?

But, you ask, how do you access the last published version of your document? Simple!

    @article.last_published_version #==> an instance of the last published version

But, you ask, how do you access an array of all the published versions of your document? Simple!

    @article.published_versions #==> an array of Memories::MilestoneProxy's of all the published versions.  
    @article.published_versions.first.revision #==> 'rev-2-jklfdsjklfdsjalkfdsa'
    @article.published_versions.first.version_number #==> 2
    @article.published_versions.first.instance #==> an instance of the first published version

## Accessing the old published version is nice, but I want to discard the draft and revert back to the last published version

Discard the working draft, you say? Simple!

    @article.discard_draft! #==> reverts the document back to the last published state and saves
    @article.published? # ==> true, since the current version is now published
    
But, you say, what if I want to discard the working draft and revert back to the last published state, but I want to save it on my own, and optionally publish the reversion? Simple!

    @article.discard_draft #==> reverts the document back to the last published state, but doesn't save
    @article.published? # ==> false, since the current version, though reverted, has not been saved
    @article.save 
    @article.published? # ==> false! it's up to you now to decide if/when you publish this reversion.


