module CouchPublish
  def self.included(base)
    base.send :include, Memories unless base.ancestors.include? Memories
    base.property :draft, TrueClass, :default => true
    base.alias_method_chain :save, :draft_logic
    base.alias_method_chain :save!, :draft_logic
  end

  def publish!(&block)
    self.draft = false
    self.milestone! &block
  end

  def save_with_draft_logic
    self.draft = true
    save_without_draft_logic
  end

  def save_with_draft_logic!
    self.draft = true
    save_without_draft_logic!
  end


  def published?
    !self.milestones.empty?
  end
end
