class WelcomeController < ApplicationController
require 'yaml'
require 'date'

def index


@selected_versions= []
@production_repo = {}
@test_repo = {}

@selected_versions=params.permit(:v25,:v30,:v35)

p @selected_versions
file = File.read('test_data.json')
pkg_hash = YAML.load(file)
p "**********cp1"*100
@production_repo = pkg_hash["Production"]
@test_repo = pkg_hash["System Test"]
@test_repo = @test_repo.sort.to_h 	
@production_repo= @production_repo.sort.to_h

end
#nothing to do with this function , just storing it as backup
def test_code
	pkg = Package.new
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
