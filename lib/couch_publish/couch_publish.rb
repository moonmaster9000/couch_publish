module CouchPublish
  def self.included(base)
    base.send :include, Memories unless base.ancestors.include? Memories
  end

  def publish!(&block)
    self.milestone! &block
  end
  
  # Returns true if this version is published
  def published?
    self.milestone? or self.milestone_commit?
  end

  # Returns true if this version has not been published
  def draft?
    not self.published?
  end
  
  # Returns the latest version of the document that was published
  def last_published_version
    self.milestones.empty? ? nil : self.milestones.last.instance
  end

  # Has any of version of this document ever been published?
  def previously_published?
    not self.milestones.empty?
  end

  # Discard the working draft, and revert the document
  # back to the last published version
  def discard_draft!(&block)
    discard_draft_exception_check
    self.rollback_to_latest_milestone!
    self.publish! &block
    self
  end

  # Discard the working draft, and revert the document
  # back to the last published state, but don't save.
  # Note that if you save the document after calling this method, 
  # you would still have to call the publish! method 
  # if you want the revert to be published
  def discard_draft
    discard_draft_exception_check
    self.rollback_to_latest_milestone
    self
  end

  def published_versions
    self.milestones
  end

  private
  def discard_draft_exception_check
    raise "The current version of the document is published. There is no working draft to discard!" if self.published?
    raise "This document has never been published. If we discard the current draft, then we'd end up in an existential conundrum." unless self.previously_published?
  end
end
