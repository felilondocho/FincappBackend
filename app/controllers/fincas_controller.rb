class FincasController < ApplicationController
	def index
		@finca = Finca.all
		@exposejson = []
		@finca.each do |x|
			@jsonfincas = {'id' => x.id,'nombre_finca' => x.nombre_finca,
				'localizacion' => x.localizacion,'clima' => x.clima,
				'capacidad' => x.capacidad,'informacion' => x.informacion,
				'lat' => x.lat,'lon' => x.lon, 'rating' => x.rating, 'precio' => x.precio,
				'idowner' => x.idowner,'owner' => x.owner}
				
			@exposejson.push(@jsonfincas)
		end

		render :json => @exposejson

	end


	def new
		@finca = Finca.new
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
	end

	def show
	end

	def update
	end

	def destroy
	end

	private

	def allowed_params
		params.require(:finca).permit(:nombre_finca, :localizacion, :clima, :capacidad,
			:informacion, :lat, :lon, :rating, :precio, :idowner, :owner);
	end 


end
