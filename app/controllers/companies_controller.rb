class CompaniesController < ApplicationController
    before_action :authenticate_user
    
    def index
        @companies = Company.where(user_id: @current_user.id)
    end

    def show
        @company = Company.find_by(id: params[:company_id])
        @ess = E.where(user_id: @current_user.id, company_id: params[:company_id])
    end

    def create
        @company = Company.new(user_id: @current_user.id, name: "new")
        if @company.save
            @es = E.new(user_id: @current_user.id, company_id: @company.id, title: "志望動機")
            @es.save
            redirect_to("/companies")
        else
            render("companies/index")
        end
    end

    def destroy
        @company = Company.find_by(id: params[:company_id])
        @ess = E.where(user_id: @current_user.id, company_id: @company.id)
        @ess.destroy_all
        @company.destroy
        redirect_to("/companies")
    end

    def edit
        @company = Company.find_by(id: params[:company_id])
    end

    def update
        @company = Company.find_by(id: params[:company_id])
        @company.name = params[:name]
        if @company.save
            redirect_to("/companies")
        else
            @name = params[:name]
            @error_message = "※再度入力して下さい。"
            render("companies/edit")
        end
    end
end
