class PapersController < ApplicationController
    before_action :authorize_request

    def index
        papers = Paper.where(users_id: helpers.get_user_id).where(is_deleted: [nil, false])
        render json: { status: :ok, data: papers }
    end

    def show
        render json: { status: :ok, data: Paper.find(params[:id]).as_json(include: [:customer, :items, :user_shop]) }
    end

    def pagination
        if(params[:page] & params[:results])
            all = Paper.where(users_id: helpers.get_user_id).where(is_deleted: [nil, false])
            # filter
            if(params[:paper_type])
                all = all.where(paper_type: params[:paper_type])
            end
            if(params[:price_unit])
                all = all.where(price_unit: params[:price_unit])
            end
            if(params[:name])
                all = all.where("name like ?", "%#{params[:name][0]}%")
            end

            all = all.includes(:items)

            papers = nil
            # sort
            if(params[:sortField])
                papers = all.order(params[:sortField] + (params[:sortOrder] == "ascend" ? "" : " DESC")).first(params[:results] * params[:page]).last(10)
            else
                papers = all.last(params[:results] * params[:page]).first(10).reverse()
            end

            papers.each do |paper|
                total_price = 0
                paper.items.each do |item|
                    total_price += item[:unit_price].to_f * item[:unit].to_f
                end
                total_price -= paper[:discount].to_f
                if paper[:paper_type] == "invoice"
                    total_price -= paper[:deposit].to_f
                end
                paper.total_price = view_context.number_with_precision(total_price, precision: 2).to_s
            end

            render json: { status: :ok, data: papers.as_json(include: :customer, methods: [:total_price]), detail: { total: all.count() } }
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
            return_valid_fail_json(paper.customer)
            paper.destroy
            return
        end

        if paper.valid? & paper.save
            # items
            items = params.permit(items: [:sort_id, :description, :unit_price, :unit])[:items]
            items.each_with_index do |item, index| items[index] = helpers.object_with_user_id(item) end

            paper.items.new(items)
            paper.items.each do |item|
                if item.valid?
                    item.save
                else
                    return_valid_fail_json(item)
                    paper.destroy
                    return
                end
            end
            
            render json: { status: :ok, data: paper, showToast: { message: "成功增加", color: "primary", timer: 2000, icon: "mdi" } }
        else
            return_valid_fail_json(paper)
        end
    end

    def update
        # puts params
        oriPaper = Paper.find(params[:id])
        newPaper = paper_params.keep_if {|k, v| ["name", "paper_type", "price_unit", "discount", "deposit", "comment"].include?(k)}
        puts "start check"
        if oriPaper.as_json.except("id", "is_deleted", "created_at", "updated_at", "users_id", "user_shops_id", "customers_id") == newPaper
            puts "1"
            oriCustomer = oriPaper.customer.as_json.except("id", "is_deleted", "created_at", "updated_at", "users_id")
            newCustomer = params.permit(customer: [:name, :address, :phone])[:customer]
            if oriCustomer == newCustomer
                puts "2"
                newItems = params.permit(items: [:sort_id, :description, :unit_price, :unit])[:items]
                if oriPaper.items.count == newItems.length
                    puts "3"
                    # compare variable
                    comparedResult = []
                    oriPaper.items.as_json.each_with_index do |item, index|
                        oriItem = item.except("id", "is_deleted", "created_at", "updated_at", "users_id", "papers_id")
                        comparedResult << (oriItem == newItems[index])
                    end
                    if comparedResult.count(true) == oriPaper.items.count
                        puts "4"
                        render json: { errors: "Don't update paper with same data" }, status: 422
                        return
                    end
                end
            end
        end

        oriPaper.assign_attributes(helpers.object_with_user_id(paper_params))
        if oriPaper.valid?
            oriPaper.customer.assign_attributes(helpers.object_with_user_id(params.permit(customer: [:name, :address, :phone])[:customer]))
            if oriPaper.customer.valid?
                items = params.permit(items: [:sort_id, :description, :unit_price, :unit])[:items]
                items.each_with_index do |item, index| items[index] = helpers.object_with_user_id(item) end
                
                newItems = []
                items.each do |item|
                    newItem = Item.new(helpers.object_with_user_id(item))
                    if !newItem.valid?
                        return_valid_fail_json(newItem)
                        return
                    end
                    newItems << item
                end
                oriPaper.items = []
                oriPaper.items_attributes = newItems
                
                if params[:isUseNewShopInfo]
                    oriPaper.user_shop = (helpers.current_User_Shop)
                end
                # oriPaper.autosave_associated_records_for_items

                oriPaper.save
                
                render json: { status: :ok, data: oriPaper, showToast: { message: "成功修改", color: "primary", timer: 2000, icon: "mdi" } }
                return
            else
                return_valid_fail_json(oriPaper.customer)
                return
            end
        else
            return_valid_fail_json(oriPaper)
            return
        end
    end

    def destroy
        paper = Paper.find(params[:id])
        paper.update(is_deleted: true)
        paper.customer.update(is_deleted: true)
        paper.items.update_all(is_deleted: true)
        render json: { status: :ok, data: paper, showToast: { message: "成功删除", color: "primary", timer: 2000, icon: "mdi" } }
    end

    private
    def paper_params
        params.permit(:name, :paper_type, :shop_id, :price_unit, :customer_id, :discount, :deposit, :comment, :is_deleted)
      # , customer: [ :name, :address, :phone ], items: [:sort_id, :description, :unit_price, :unit]
    end
end
