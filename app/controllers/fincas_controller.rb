class FincasController < ApplicationController
	def index
		@finca = Finca.all
		@arrayimg = []
		@exposejson = []
		@finca.each do |x|
			@arrayimg =[]
			x.images.each do |w|
					@arrayimg.push(w.url)
			end
			@ratingfinca = sacarrating(x.id)
			@jsonfincas = {'id' => x.id,'nombre_finca' => x.nombre_finca,
				'localizacion' => x.localizacion,'clima' => x.clima,
				'capacidad' => x.capacidad,'informacion' => x.informacion,
				'lat' => x.lat,'lon' => x.lon, 'rating' => @ratingfinca, 'precio' => x.precio,
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

	def filterclima
		@clima = params[:clima]
		@fincaconclima = Finca.where(clima: @clima)

		@arrayimg = []
		@exposejson = []
		@fincaconclima.each do |x|
			@arrayimg =[]
			x.images.each do |w|
					@arrayimg.push(w.url)
			end

			@ratingfinca = sacarrating(x.id)
			@jsonfincas = {'id' => x.id,'nombre_finca' => x.nombre_finca,
				'localizacion' => x.localizacion,'clima' => x.clima,
				'capacidad' => x.capacidad,'informacion' => x.informacion,
				'lat' => x.lat,'lon' => x.lon, 'rating' => @ratingfinca, 'precio' => x.precio,
				'idowner' => x.idowner,'owner' => x.owner,'imagen' => @arrayimg}
			
			@exposejson.push(@jsonfincas)
		end

		 render :json => @exposejson

	end

	def filterlocalizacion
		@localizacion = params[:localizacion]
		@fincaconlocalizacion = Finca.where(localizacion: @localizacion)

		@arrayimg = []
		@exposejson = []
		@fincaconlocalizacion.each do |x|
			@arrayimg =[]
			x.images.each do |w|
				@arrayimg.push(w.url)
			end

			@ratingfinca = sacarrating(x.id)
			@jsonfincas = {'id' => x.id,'nombre_finca' => x.nombre_finca,
				'localizacion' => x.localizacion,'clima' => x.clima,
				'capacidad' => x.capacidad,'informacion' => x.informacion,
				'lat' => x.lat,'lon' => x.lon, 'rating' => @ratingfinca, 'precio' => x.precio,
				'idowner' => x.idowner,'owner' => x.owner,'imagen' => @arrayimg}
			
			@exposejson.push(@jsonfincas)
		end

		 render :json => @exposejson
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

	def sacarrating(idfinca)
		@idfinca = idfinca
		@finca = Finca.find(@idfinca)
		@totaldevotos = @finca.rating.votos1+@finca.rating.votos2+
			@finca.rating.votos3+@finca.rating.votos4+@finca.rating.votos5
		@result = 0.0
		@result = (((1*@finca.rating.votos1)+(2*@finca.rating.votos2)+(3*@finca.rating.votos3)+
			(4*@finca.rating.votos4)+(5*@finca.rating.votos5))/@totaldevotos)
		return @result
	end

	def rating
		@idfinca = params[:id]
		@finca = Finca.find(@idfinca)
		@totaldevotos = @finca.rating.votos1+@finca.rating.votos2+
			@finca.rating.votos3+@finca.rating.votos4+@finca.rating.votos5
		@result = 0.0
		@result = (((1*@finca.rating.votos1)+(2*@finca.rating.votos2)+(3*@finca.rating.votos3)+
			(4*@finca.rating.votos4)+(5*@finca.rating.votos5))/@totaldevotos)
		puts @result
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
