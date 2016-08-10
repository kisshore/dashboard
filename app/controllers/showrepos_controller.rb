class ShowreposController < ApplicationController
	require 'yaml'
	require 'date'

	def index
		@production_repo = {}
		@test_repo = {}
	end

	def fetch
		@production_repo = {}
		@test_repo = {}
		@filename = ""

		#Please give file path here, this is mandatory
		@filepath = "/opt/repo-dashboard/"

                if not params[:repo].nil? 
                        if not params[:repo][:service].nil?
                                if not params[:repo][:version].nil?
                			@filename = @filepath + params[:repo][:service] + '_' + params[:repo][:version].split('.').join('_') + '.json'
                                end
                        end
		end

		if File.file?(@filename)
			file = File.read(@filename)
			pkg_hash = YAML.load(file)
                        if pkg_hash.key?("Production")
         			@production_repo = pkg_hash["Production"]
			        @production_repo= @production_repo.sort.to_h
                        end
                        if pkg_hash.key?("System Test")
		        	@test_repo = @test_repo.sort.to_h
	         		@test_repo = pkg_hash["System Test"]
                        end
		else
			@file_existence = 'Data file missing, please check the cron job'
		end
	end
end
