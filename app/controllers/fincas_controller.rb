class FincasController < ApplicationController
    def index
        @finca = Finca.all.order("id")
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
        @finca.build_rating
    end

    def create
        @finca = Finca.new(allowed_params)

        if @finca.save()
            redirect_to fincas_path
        else
            render "new"
        end

    end

    def filter
        #filter/:clima/:localizacion/:precio/:personas
        @queryArray=[]
        flag = false
        if params[:clima] != "no"
            @clima = params[:clima]
            @queryArray.push("clima = ?")
            @queryArray.push(@clima)
            flag = true
        end
        if params[:localizacion] != "no"
            @localizacion = params[:localizacion]
            if flag == true
                @queryArray[0] += (" AND localizacion = ?")
                @queryArray.push(@localizacion)
            else
                @queryArray.push("localizacion = ?")
                @queryArray.push(@localizacion)
            end
            flag = true
        end
        if params[:precio] != "no"
            @precio = params[:precio]
            if flag == true
                @queryArray[0] += (" AND precio = ?")
                @queryArray.push(@precio)            
            else
                @queryArray.push("precio = ?")
                @queryArray.push(@precio)
            end
            flag = true
        end
        if params[:personas] != "no"
            @capacidad = params[:personas]
            if flag == true
                @queryArray[0] += (" AND capacidad = ?")
                @queryArray.push(@capacidad)            
            else
                @queryArray.push("capacidad = ?")
                @queryArray.push(@capacidad)
            end
        end


        @fincafiltrada = Finca.where(@queryArray)

        @arrayimg = []
        @exposejson = []
        @fincafiltrada.each do |x|
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
        if @totaldevotos > 0
            @result = (((1*@finca.rating.votos1)+
                (2*@finca.rating.votos2)+(3*@finca.rating.votos3)+
            (4*@finca.rating.votos4)+(5*@finca.rating.votos5))/@totaldevotos)
        else
            @result = 0
        end
        return @result
    end

    def show
    end

    def getAtt
        @exposejson = []
        @climas =[]
        @localizaciones = []
        @precios = []
        @capacidades = []

        @fincaclimas = Finca.select(:clima).distinct
        @fincaclimas.each do |x|
            @climas += [x.clima]
        end
        @exposejson += ["clima" => @climas]

        @fincalocalizacion = Finca.select(:localizacion).distinct
        @fincalocalizacion.each do |x|
            @localizaciones += [x.localizacion]
        end
        @exposejson += ["localizacion" => @localizaciones]

        @fincaprecio = Finca.select(:precio).distinct
        @fincaprecio.each do |x|
            @precios += [x.precio]
        end
        @exposejson += ["precio" => @precios]

        @fincacapacidad = Finca.select(:capacidad).distinct
        @fincacapacidad.each do |x|
            @capacidades += [x.capacidad]
        end
        @exposejson += ["capacidad" => @capacidades]

        render :json => @exposejson

    end

    def getAttClima
        @exposejson = []
        @localizaciones = []
        @precios = []
        @capacidades = []
        @pay = JSON.parse(request.body.read)
        @clima = @pay["clima"]
        @flagClima = false
        @queryArray=[]
        if(@clima != "no")
            @queryArray.push("clima = ?")
            @queryArray.push(@clima)
            @flagClima = true
        else
            @queryArray.push("clima != ?")
            @queryArray.push("@clima")
        end

        @fincalocalizacion = Finca.select(:localizacion).where(@queryArray).distinct
        @fincalocalizacion.each do |x|
            @localizaciones += [x.localizacion]
        end
        @exposejson += ["localizacion" => @localizaciones]
        render :json => @exposejson
    end

    def getAttLoc
        @exposejson = []
        @precios = []
        @capacidades = []
        @pay = JSON.parse(request.body.read)
        @cli = @pay["clima"]
        @loc = @pay["localizacion"]
        @queryArray=[]
        flag = false
        if @cli != "no"
            @queryArray.push("clima = ?")
            @queryArray.push(@cli)
            flag = true
        end
        if @loc != "no"
            if flag == true
                @queryArray[0] += (" AND localizacion = ?")
                @queryArray.push(@loc)
            else
                @queryArray.push("localizacion = ?")
                @queryArray.push(@loc)
            end
        end
        
        @fincaprecio = Finca.select(:precio).where(@queryArray).distinct
        @fincaprecio.each do |x|
            @precios += [x.precio]
        end
        @exposejson += ["precio" => @precios]

        render :json => @exposejson
    end

    def getAttPrec
        @exposejson = []
        @climas = []
        @localizaciones = []
        @capacidades = []
        @pay = JSON.parse(request.body.read)
        @cli = @pay["clima"]
        @loc = @pay["localizacion"]
        @precio = @pay["precio"].to_s
        @queryArray=[]
        flag = false
        if @cli != "no"
            @queryArray.push("clima = ?")
            @queryArray.push(@cli)
            flag = true
        end
        if @loc != "no"
            if flag == true
                @queryArray[0] += (" AND localizacion = ?")
                @queryArray.push(@loc)
            else
                @queryArray.push("localizacion = ?")
                @queryArray.push(@loc)
            end
            flag = true
        end
        if @precio != "no"
            if flag == true
                @queryArray[0] += (" AND precio = ?")
                @queryArray.push(@precio)            
            else
                @queryArray.push("precio = ?")
                @queryArray.push(@precio)
            end
            flag = true
        end

        @fincacapacidad = Finca.select(:capacidad).where(@queryArray).distinct
        @fincacapacidad.each do |x|
            @capacidades += [x.capacidad]
        end
        @exposejson += ["capacidad" => @capacidades]

        render :json => @exposejson
    end

    def destroy
    end

    private

    def allowed_params
        params.require(:finca).permit(:nombre_finca, :localizacion,
         :clima, :capacidad,
            :informacion, :lat, :lon, :rating, :precio, :idowner, :owner,
             images_attributes: [:id, :url, :_destroy],
            rating_attributes:[:id,:votos1,:votos2,:votos3,:votos4,:votos5]);
    end 


end
