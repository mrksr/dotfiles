require 'shellwords'
unless sibling_types.member? "text/plain"
  case content_type
  when "text/html"
      `/usr/bin/elinks -dump -no-numbering -no-references -no-home -default-mime-type #{content_type} #{Shellwords.escape filename} | /usr/bin/sed 's/^...//'`
  end
end
