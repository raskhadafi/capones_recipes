Dir.glob(File.join(File.dirname(__FILE__), '/airbrake/*.rb')).sort.each { |f| load f }