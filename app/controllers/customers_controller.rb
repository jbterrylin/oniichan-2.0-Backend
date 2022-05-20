class CustomersController < ApplicationController
    before_action :authorize_request

    def index
        customers = Customer.all
        render json: { status: :ok, data: customers.as_json(include: [  papers: {only: [:id]}  ]) }
    end

    def pagination
        puts params
        if(params[:page] & params[:results])
            all = Customer.where(users_id: helpers.get_user_id).where(is_deleted: [nil, false])

            # # filter
            if(params[:name])
                all = all.where("name like ?", "%#{params[:name][0]}%")
            end
            if(params[:address])
                all = all.where("address like ?", "%#{params[:address][0]}%")
            end
            if(params[:phone])
                all = all.where("phone like ?", "%#{params[:phone][0]}%")
            end

            customers = nil
            # sort
            if(params[:sortField])
                customers = all.order(params[:sortField] + (params[:sortOrder] == "ascend" ? "" : " DESC")).first(params[:results] * params[:page]).last(10)
            else
                customers = all.last(params[:results] * params[:page]).first(10).reverse()
            end

            render json: { status: :ok, data: customers.as_json(include: [  papers: {only: [:id, :name]}  ]), detail: { total: all.count() } }
            return
        end
        render json: { errors: "don't have enough variable" }, status: 422
    end

    def like
        customer = Customer.find(params[:id])
        puts customer.like
        if(!customer.like?)
            customer.like = true
        else
            customer.like = !customer.like
        end
        customer.save()
    end
end
