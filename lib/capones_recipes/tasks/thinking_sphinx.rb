Dir.glob(File.join(File.dirname(__FILE__), '/thinking_sphinx/*.rb')).sort.each { |f| require f }