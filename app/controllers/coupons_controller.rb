class CouponsController < ApplicationController

    before_action :authenticate_user!
    
    def inactivate
        @coupon = Coupon.find(params[:id])
        @coupon.inactive!
        redirect_to @coupon.promotion
    end

    def activate
        @coupon = Coupon.find(params[:id])
        @coupon.active!
        redirect_to @coupon.promotion
    end

end