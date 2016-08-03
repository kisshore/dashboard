class WelcomeController < ApplicationController
require 'yaml'
require 'date'

def index

pkg = Package.new

file = File.read('details.json')
pkg_hash = YAML.load(file)
p "**********cp1"

if(!Package.last.nil?)
	p "**********cp2"
	if(Date.today.to_date != Package.last.updated_at)
		pkg_hash.each_key do |key|
			 pkg.component = pkg_hash[key]
		end
	end
elsif(Package.last.nil?)
	p  "**********cp3"
	 pkg_hash.each_key do |key|
                         pkg.component = pkg_hash[key]
                end

end

pkg.save
p "**********cp4"

@packages = Package.all
end

end
