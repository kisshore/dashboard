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

        unless params[:repo].nil?
			@filename = @filepath + params[:repo][:service] + '_' + params[:repo][:version].split('.').join('_') + '.json'
			p @filename
		end

		if File.file?(@filename)
			file = File.read(@filename)
			pkg_hash = YAML.load(file)
			@production_repo = pkg_hash["Production"]
			@test_repo = pkg_hash["System Test"]
			@test_repo = @test_repo.sort.to_h
			@production_repo= @production_repo.sort.to_h
		else
			@file_existence = 'Data file missing, please check the cron job'
		end
	end
end