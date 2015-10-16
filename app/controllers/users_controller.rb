class UsersController < ApplicationController

	def index
        @user = User.all.order("id")
        @exposejson = []
        @user.each do |x|
            @jsonfincas = {'username' => x.username}
            @exposejson.push(@jsonfincas)
        end
         render :json => @exposejson
	end

	def new
		
	end

	def create
		
	end

	def edit
	end


	def update
	end

    def newUser
        @pay = JSON.parse(request.body.read)
        @name = @pay["name"]
        @lastname = @pay["lastname"]
        @username = @pay["username"]
        @cc = @pay["cc"]
        @email = @pay["email"]
        @telephone = @pay["telephone"]
        @cellphone = @pay["cellphone"]
        @password = @pay["password"]
        @user = User.new(:finca_id => 0,:nombre => @name,
            :apellidos => @lastname, :username => @name,
            :cedula => @cc,:email => @email,:telefono => @telephone,
            :celular => @cellphone,:password => @password)
        if @user.save()
            @jsonresponse = {'status' => "done"}
            render :json => @jsonresponse
        else
            @jsonresponse = {'status' => "no"}
            render :json => @jsonresponse
        end
    end
end
