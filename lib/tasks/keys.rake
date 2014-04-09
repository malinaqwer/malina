require 'csv'

task parse_csv: :environment do
  CSV.foreach('import/lololo.csv', headers: true) do |row|
    page = Page.new
    page.title = row[0]
    page.alias = ImportsController.slug row[0]
    page.save!
  end
end
