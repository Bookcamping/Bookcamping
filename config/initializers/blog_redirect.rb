

BLOG_REDIRECTS = {}
File.open("#{Rails.root}/config/blog_migration.txt").each do |line|
  s, d = line.split
  BLOG_REDIRECTS.store(s[1..-1], d) if s
end

