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
        @userexist = User.where("username = ? AND password = ?",@username,@password)
        @userfound = false
        @userexist.each do |result|
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

        @userexist = User.where("username = ?",@username)
        @userccexist = User.where("cedula = ?",@cc)
        @userfound = false
        @userexist.each do |result|
            @userfound = true
        end
        @userccexist.each do |result|
            @userfound = true
        end
        if(@userfound)
            @user = User.new(:finca_id => 0,:nombre => @name,
                :apellidos => @lastname, :username => @username,
                :cedula => @cc,:email => @email,:telefono => @telephone,
                :celular => @cellphone,:password => @password)
            if @user.save()
                @jsonresponse = {'status' => "done"}
                render :json => @jsonresponse
            else
                @jsonresponse = {'status' => "no"}
                render :json => @jsonresponse
            end
        else
            @jsonresponse = {'status' => "no"}
            render :json => @jsonresponse
        end
    end
end
