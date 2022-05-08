class PapersController < ApplicationController
    before_action :authorize_request

    def index
        papers = Paper.all
        render json: { status: :ok, data: papers }
    end

    def pagination
        if(params[:page] & params[:results])
            all = Paper.where(users_id: helpers.get_user_id)
            # filter
            if(params[:paper_type])
                all = all.where(paper_type: params[:paper_type])
            end
            if(params[:price_unit])
                all = all.where(price_unit: params[:price_unit])
            end

            papers = nil

            # sort
            if(params[:sortField])
                papers = all.order(params[:sortField] + (params[:sortOrder] == "ascend" ? "" : " DESC")).first(params[:results] * params[:page]).last(10)
            else
                papers = all.last(params[:results] * params[:page]).first(10).reverse
            end

            render json: { status: :ok, data: papers, detail: { total: all.count() } }
            return
        end
        render json: { errors: "don't have enough variable" }, status: 422
    end

    def create
        paper = Paper.new(helpers.object_with_user_id(paper_params))
        paper.user_shop = helpers.current_User_Shop

        # customer
        customer = params.permit(customer: [:name, :address, :phone])[:customer]
        paper.create_customer(helpers.object_with_user_id(customer))
        if !paper.customer.valid?
            helpers.return_valid_fail_json(paper.customer)
            paper.destroy
            return
        end

        if paper.valid? & paper.save
            # items
            items = params.permit(items: [:sort_id, :description, :unit_price, :unit])[:items]
            items.each_with_index do |item, index| items[index] = helpers.object_with_user_id(item) end

            paper.items.new(items)
            paper.items.each do |item|
                if !item.valid?
                    helpers.return_valid_fail_json(item)
                    paper.destroy
                    return
                end
            end
            render json: { status: :ok, data: paper, showToast: { message: "成功", color: "primary", timer: 2000, icon: "mdi" } }
        else
            helpers.return_valid_fail_json(paper)
        end
    end

    private

    def paper_params
        params.permit(:name, :paper_type, :shop_id, :price_unit, :customer_id, :discount, :deposit, :is_deleted)
      # , customer: [ :name, :address, :phone ], items: [:sort_id, :description, :unit_price, :unit]
    end
end
