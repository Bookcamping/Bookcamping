

BLOG_REDIRECTS_IDS = {}
BLOG_REDIRECTS_SLUG = {}
BLOG_REDIRECTS_REGEXP = {}
File.open("#{Rails.root}/config/blog_migration.txt").each do |line|
  i, s, d = line.split
  BLOG_REDIRECTS_IDS.store(i, d) if s
  BLOG_REDIRECTS_SLUG.store(s[1..-1], d) if s
  regexp = Regexp.new("(^#{i}$|^#{i}-|#{s})")
  BLOG_REDIRECTS_REGEXP.store(regexp, d) if s
end

