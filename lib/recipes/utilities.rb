require 'fileutils'

module Utilities
  # utilities.ask('What is your name?', 'John')
  def ask(question, default='')
    question = "\n" + question.join("\n") if question.respond_to?(:uniq)
    answer = Capistrano::CLI.ui.ask(space(question)).strip
    answer.empty? ? default : answer
  end

  # utilities.yes?('Proceed with install?')
  def yes?(question)
    question = "\n" + question.join("\n") if question.respond_to?(:uniq)
    question += ' (y/n)'
    ask(question).downcase.include? 'y'
  end
  
  def init_file(file, find, replace, target)
    content = File.open(file).read
    content.gsub!(find,replace)
    put content, target
  end
end
