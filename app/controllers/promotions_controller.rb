class PromotionsController < ApplicationController

    before_action :authenticate_user!

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

    def edit
        @promotion = Promotion.find(params[:id])
    end

    def update
        @promotion = Promotion.find(params[:id])
        @promotion.update(allowed_params)
        if @promotion.save
            redirect_to promotion_path(@promotion)
        else
            render :edit
        end
    end

    def delete 
        @promotion = Promotion.find(params[:id])
    end

    def destroy
        @promotion = Promotion.find(params[:id])
        @promotion.delete
        redirect_to promotions_path
    end

    def generate_coupons
        @promotion = Promotion.find(params[:id])
        if @promotion.generate_coupons!
            flash[:notice] = 'Coupons generated with success'
        else
            flash[:notice] = 'Can\'t generate again'
        end
        redirect_to promotion_path(@promotion.reload)
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