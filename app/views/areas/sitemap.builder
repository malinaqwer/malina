
xml.instruct!              # for the <?xml version="1.0" encoding="UTF-8"?> line
xml.urlset do               # xml.foo creates foo element
  Area.each do |area|
    xml.url do
      xml.loc 'http://kupispais/' + area.slug
      xml.priority '1'
    end
  end
end