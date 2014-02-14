domain = 'http://kupispais/'
xml.instruct!              # for the <?xml version="1.0" encoding="UTF-8"?> line
xml.urlset do               # xml.foo creates foo element
  @areas.each do |area|
    @pages.each do |page|
      xml.url do
        xml.loc domain + area.slug + '/' + page.slug
        xml.priority '1'
      end
    end
  end
end