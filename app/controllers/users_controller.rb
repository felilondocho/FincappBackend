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

    def login
        @pay = JSON.parse(request.body.read)
        @username = @pay["username"]
        @password = @pay["password"]
        @user = User.where("username = ? AND password = ?",@username,@password)
        @userfound = false
        @user.each do |result|
            @user_id = result.id
            @userfound = true
        end
        if(@userfound)
            @jsonresponse = {'status' => @user_id}
        else
            @jsonresponse = {'status' => 0}
        end
        
        render :json => @jsonresponse
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
