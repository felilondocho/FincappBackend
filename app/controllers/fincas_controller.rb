class FincasController < ApplicationController
	def index
		@finca = Finca.all
		@arrayimg = []
		@exposejson = []
		@finca.each do |x|
			x.images.each do |w|
				#if(w.finca_id == x.id)
					@arrayimg.push(w.url)
				#end
			end
			@jsonfincas = {'id' => x.id,'nombre_finca' => x.nombre_finca,
				'localizacion' => x.localizacion,'clima' => x.clima,
				'capacidad' => x.capacidad,'informacion' => x.informacion,
				'lat' => x.lat,'lon' => x.lon, 'rating' => x.rating, 'precio' => x.precio,
				'idowner' => x.idowner,'owner' => x.owner,'imagen' => @arrayimg}
			
			@exposejson.push(@jsonfincas)
		end


		 render :json => @exposejson

	end


	def new
		@finca = Finca.new
		4.times{@finca.images.build}
	end

	def create
		@finca = Finca.new(allowed_params)

		if @finca.save()
			redirect_to fincas_path
		else
			render "new"
		end

	end

	def edit
		@finca = Finca.find(params[:id])
	end

	def update
		@finca = Finca.find(params[:id])

		if @finca.update_attributes(allowed_params)
			redirect_to fincas_path
		else
			render "new"
		end
	end

	def show
	end



	def destroy
	end

	private

	def allowed_params
		params.require(:finca).permit(:nombre_finca, :localizacion, :clima, :capacidad,
			:informacion, :lat, :lon, :rating, :precio, :idowner, :owner, images_attributes: [:id, :url, :_destroy]);
	end 


end
