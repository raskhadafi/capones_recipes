Dir.glob(File.join(File.dirname(__FILE__), '/rails/*.rb')).sort.each { |f| require f }