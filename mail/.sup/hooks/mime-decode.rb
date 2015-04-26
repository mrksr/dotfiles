require 'shellwords'
unless sibling_types.member? "text/plain"
  case content_type
  when "text/html"
      # `/usr/bin/elinks -dump -no-numbering -no-references -no-home -default-mime-type #{content_type} #{Shellwords.escape filename}`
      `w3m -o alt_entity=0 -I #{charset} -O utf-8 -dump -T #{content_type} #{Shellwords.escape filename}`
  end
end
