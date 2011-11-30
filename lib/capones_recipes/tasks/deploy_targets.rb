Dir.glob(File.join(File.dirname(__FILE__), '/deploy_targets/*.rb')).sort.each { |f| require f }
