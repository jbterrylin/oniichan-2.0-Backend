class PapersController < ApplicationController
    before_action :authorize_request
    before_action :set_paper, only: %i[ show edit update destroy ]

    def index
        papers = Paper.all
        render json: { status: :ok, data: papers }
    end

    def create
        if(params[:page] & params[:results])
            # for get with pagination
            # todo
            papers = Paper.where(user_id: get_user_id)
            render json: { status: :ok, data: papers, detail: { total: papers.count } }
        else
            paper = Paper.new(object_with_user_id(paper_params))

            if paper.save
                begin
                    items = params.permit(items: [:sort_id, :description, :unit_price, :unit])[:items]
                    items.each do |item| object_with_user_id(item) end
                
                    paper.items.create(items)

                    if !paper.items.all?(&:valid?) 
                        paper.destroy
                        render json: { errors: "fail to create data" }, status: 404
                        return
                    end
                    
                    customer = params.permit(customer: [:name, :address, :phone])[:customer]
                    paper.create_customer(object_with_user_id(customer))

                    if !paper.customer.valid?
                        paper.destroy
                        render json: { errors: "fail to create data" }, status: 404
                        return
                    end
                rescue => e
                    render json: { errors: e.class.name + e.message }, status: 404
                end
            else

            end
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper
        @paper = Paper.find_by(id: get_user_id)
    end

    def paper_params
        params.permit(:name, :paper_type, :shop_id, :price_unit, :customer_id, :discount, :deposit, :is_deleted)
      # , customer: [ :name, :address, :phone ], items: [:sort_id, :description, :unit_price, :unit]
    end
end
