class FavoritesController < ApplicationController


	def index
		@fav = Favorite.all.order("id")
        @exposejson = []
        @user.each do |x|
            @jsonfincas = {'userId' => x.user_id,'fincaId' => x.finca_id}
            @exposejson.push(@jsonfincas)
        end

         render :json => @exposejson
	end

	def userFav
		@userId = params[:idUser]
		@arrayimg = []
        @exposejson = []
		@query = "user_id = '" + @userId + "'"
		@favs = Favorite.where(@query)
		@favs.each do |result|
			@fincaId = result.finca_id
			@finca = Finca.find(@fincaId)

			@arrayimg =[]
            @finca.images.each do |w|
                    @arrayimg.push(w.url)
            end
            #@ratingfinca = sacarrating(@finca.id)
            @jsonfincas = {'id' => @finca.id,'nombre_finca' => @finca.nombre_finca,
                'localizacion' => @finca.localizacion,'clima' => @finca.clima,
                'capacidad' => @finca.capacidad,'informacion' => @finca.informacion,
                'lat' => @finca.lat,'lon' => @finca.lon, 'precio' => @finca.precio,
                'idowner' => @finca.idowner,'owner' => @finca.owner,'imagen' => @arrayimg}
            
            @exposejson.push(@jsonfincas)
		end
		render :json => @exposejson
	end

end
