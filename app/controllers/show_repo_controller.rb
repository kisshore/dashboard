class ShowRepoController < ApplicationController
	require 'yaml'
	require 'date'

	def index
		@production_repo = {}
		@test_repo = {}

		if File.file?('test_data.json')
			file = File.read('test_data.json')
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