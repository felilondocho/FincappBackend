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
      @favs = Favorite.where("user_id = ?",@userId)
      @favs.each do |result|
         @fincaId = result.finca_id
         @finca = Finca.find(@fincaId)

         @arrayimg =[]
         @finca.images.each do |w|
            @arrayimg.push(w.url)
        end
        @ratingfinca = sacarrating(@finca.id)
        @jsonfincas = {'id' => @finca.id,'nombre_finca' => @finca.nombre_finca,
            'localizacion' => @finca.localizacion,'clima' => @finca.clima,
            'capacidad' => @finca.capacidad,'informacion' => @finca.informacion,
            'lat' => @finca.lat,'lon' => @finca.lon,'rating' => @ratingfinca,
            'precio' => @finca.precio,'idowner' => @finca.idowner,
            'owner' => @finca.owner,'imagen' => @arrayimg}
            
            @exposejson.push(@jsonfincas)
        end
        render :json => @exposejson
    end

    def sacarrating(idfinca)
        @idfinca = idfinca
        @finca = Finca.find(@idfinca)
        @totaldevotos = @finca.rating.votos1+@finca.rating.votos2+
        @finca.rating.votos3+@finca.rating.votos4+@finca.rating.votos5
        @result = 0.0
        if @totaldevotos > 0
            @result = (((1*@finca.rating.votos1)+
                (2*@finca.rating.votos2)+(3*@finca.rating.votos3)+
                (4*@finca.rating.votos4)+(5*@finca.rating.votos5))/@totaldevotos)
        else
            @result = 0
        end
        return @result
    end

    def addUserFav
        @pay = JSON.parse(request.body.read)
        @fincaId = @pay["id_finca"]
        @userId = @pay["id_user"]
        @favexist = Favorite.where("user_id = ? AND finca_id = ?",@userId,@fincaId)
        @favexistflag = false
        @favexist.each do |x|
            @favexistflag = true
        end
        if(@favexistflag)
            @jsonresponse = {'status' => "done"}
            render :json => @jsonresponse
        else
            @fav = Favorite.new(:user_id => @userId,:finca_id => @fincaId)
            if @fav.save()
                @jsonresponse = {'status' => "done"}
                render :json => @jsonresponse
            else
                @jsonresponse = {'status' => "no"}
                render :json => @jsonresponse
            end
        end
    end
end
