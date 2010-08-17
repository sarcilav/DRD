def separator
  "----xx324retbnoiugsdg--sd=s[[[[]p-------"
end
def decode_separator(stream)
  stream.gsub(separator,"\n")
end
