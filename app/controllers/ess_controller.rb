class EssController < ApplicationController
    before_action :authenticate_user

    def create
        @es = E.new(user_id: @current_user.id, company_id: params[:company_id], title: "new")
        if @es.save
            redirect_to("/companies/#{params[:company_id]}")
        else
            render("companies/index")
        end
    end

    def edit
        @es = E.find_by(id: params[:es_id])
        @company = Company.find_by(id: params[:company_id])
    end

    def update
        @es = E.find_by(id: params[:es_id])
        @es.title = params[:title]
        @es.content = params[:content]
        if @es.save
            redirect_to("/companies/#{params[:company_id]}")
        else
            redirect_to("/companies/#{params[:company_id]}")
        end
    end

    def destroy
        @es = E.find_by(id: params[:es_id])
        @es.destroy
        redirect_to("/companies/#{params[:company_id]}")
    end
end
