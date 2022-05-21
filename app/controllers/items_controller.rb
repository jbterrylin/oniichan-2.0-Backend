class ItemsController < ApplicationController
    before_action :authorize_request

    def index
        item = Item.where(users_id: helpers.get_user_id).where(is_deleted: [nil, false])
        render json: { status: :ok, data: item }
    end

    def pagination
        if(params[:page] & params[:results])
            all = Item.where(users_id: helpers.get_user_id).where(is_deleted: [nil, false]).where.not(unit: [nil, ''])

            # filter
            if(params[:description])
                all = all.where("description like ?", "%#{params[:description][0]}%")
            end
            if(params[:unit_price])
                all = all.where("cast(unit_price as float) >= ? AND cast(unit_price as float) <= ?", params[:unit_price][0][0], params[:unit_price][0][1])
            end
            if(params[:unit])
                all = all.where("cast(unit as float) >= ? AND cast(unit as float) <= ?", params[:unit][0][0], params[:unit][0][1])
                puts all
            end

            all = all.includes(:paper)

            items = nil
            # sort
            if(params[:sortField])
                items = all.order(params[:sortField] + (params[:sortOrder] == "ascend" ? "" : " DESC")).first(params[:results] * params[:page]).last(10)
            else
                items = all.last(params[:results] * params[:page]).first(10).reverse()
            end

            puts "---"
            unit_prices = Item.where(users_id: helpers.get_user_id).where(is_deleted: [nil, false]).where.not(unit: [nil, '']).map(&:unit_price).map(&:to_f)
            units = Item.where(users_id: helpers.get_user_id).where(is_deleted: [nil, false]).where.not(unit: [nil, '']).map(&:unit).map(&:to_f)

            render json: { status: :ok, data: items.as_json(include: :paper), detail: { total: all.count(), unit_price: [unit_prices.min, unit_prices.max], unit: [units.min, units.max] } }
            return
        end
        render json: { errors: "don't have enough variable" }, status: 422
    end
end
