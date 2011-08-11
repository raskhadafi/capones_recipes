Capistrano::Configuration.instance.load do
  namespace :kuhsaft do
    namespace :sync do
      desc "Syncs down the tables of kuhsaft"
      task :down do
        puts 'TODO: kuhsaft down'
      end

      desc "Syncs up the tables of kuhsaft"
      task :up do
        puts 'TODO: kuhsaft up'
      end
    end
  end
end
