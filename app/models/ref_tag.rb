class RefTag < ActsAsTaggableOn::Tag
  def references
    Book.tagged_with(self.name)
  end
end

