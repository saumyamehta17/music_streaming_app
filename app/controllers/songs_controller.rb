class SongsController < ApplicationController
	def index
		@songs = S3_BUCKET.objects
	end

	def new
	end	

	def upload
		begin
			key = params[:mp3].original_filename
			obj = S3_BUCKET.objects[key.gsub(/[\-\.()]/,'_')]
	    # Upload the file
	    obj.write(
	    	file: params[:mp3],
	    	acl: :public_read
	    	)
	    redirect_to songs_index_path
	  rescue
	  	render text: 'Issue in upload'
	  end    
	end

	def delete
		byebug
		begin
			S3_BUCKET.objects[params[:id]].delete
			redirect_to songs_index_path
		rescue
			render text: 'No song Found'
		end
	end
end
