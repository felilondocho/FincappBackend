class RatingController < ApplicationController

	def index
		@rating = Rating.find(1)
		@votos = "votos1"
		puts @rating[@votos]
	end




	def new
		@rating = Rating.new
	end

	def create
		@rating = Rating.new
	end

	def edit
	end

	def curl_example
		@pay = request.body.read
		puts @pay
		render text: 'Thanks for sending a GET request with cURL!'+@pay
	end

	def curl_example_post
		@pay = JSON.parse(request.body.read)
		render text: "You send: " + @pay["nombre"] + " and " + @pay["texto"]
	end

	def update
	end

	def addrating
		@rating = Rating.find(params[:id])
		@votos = "votos"+params[:rating]
		@resultado = @rating[@votos] + 1
		if @rating.update_attribute(@votos,@resultado)
			@jsonresponse = {'status' => "done"}
			render :json => @jsonresponse
		else
			@jsonresponse = {'status' => "error"}
			render :json => @jsonresponse
		end
	end

end
