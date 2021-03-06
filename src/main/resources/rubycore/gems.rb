require_relative "paths"

module RubyCore
	module Gems
		@path = RubyCore::Paths.new
		def self.process_gems(gems)
			unless gems.empty?
				require "rubygems"
				Gem.paths = {'GEM_HOME' => @path.gems_folder}
			end

			gems.each {|g| load_gem(g) }
		end

		
		def self.require_gem(g)
			if g.is_a?(Hash)
				if g[:as]
					require g[:as]
				else
					require g[:rubygem]
				end
			else
				require g
			end
		end

		def self.load_gem(g)
			begin
				require_gem(g)
			rescue LoadError
					download_gems(g)
				begin
					require_gem(g)
				rescue LoadError
					puts "Sorry but i can't install the #{g[:rubygem]}, sorry :("
				end
			end
		end
		
		def self.download_gems(g)
			ruby = system "ruby -v"
			if ruby
				system "gem install -i #{@path.gems_folder} #{g[:rubygem]} --no-rdoc --no-ri --verbose"
			else
				system "java -jar #{File.join(@path.minecraft_folder, 'mods')}/jruby-complete.jar -S gem install -i #{@path.gems_folder} #{g[:rubygem]} --no-rdoc --no-ri --verbose"
			end
		end
	end
end
