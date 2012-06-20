require 'rake'

Gem::Specification.new do |s|
  s.name        = 'huffshell'
  s.version     = '0.0.5'
  s.date        = '2012-06-18'
  s.summary     = "Automatic shell alias recommondations based on usage!"
  s.description = "A parser and recommendation system for your shell aliases based on your shell history"
  s.authors     = ["Paul McKellar"]
  s.email       = 'paul.mckellar@gmail.com'
  s.files       = FileList['lib/**/*.rb',
                           'lib/*.rb',
                           'bin/*',
                           '[A-Z]*',
                           'test/**/*'].to_a
  s.homepage    = 'https://github.com/paulmars/huffshell'
  s.executables << 'huffshell'
  s.add_dependency "colorize"
end
