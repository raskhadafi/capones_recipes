Dir.glob(File.join(File.dirname(__FILE__), '/restful_authentication/*.rb')).sort.each { |f| load f }
