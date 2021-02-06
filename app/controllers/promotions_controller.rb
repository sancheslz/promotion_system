class PromotionsController < ApplicationController
    def index
        @promotions = Promotion.all
    end

    def show
        @promotion = Promotion.find(params[:id])
    end

    def new
        @promotion = Promotion.new
    end

    def create
        @promotion = Promotion.new(allowed_params)
        if @promotion.save
            redirect_to promotion_path(@promotion)
        else
            render :new
        end
    end

    private
    def allowed_params
        params.require(:promotion).permit(
            :name,
            :description,
            :code,
            :discount_rate,
            :coupon_quantity,
            :expiration_date
        )
    end
end