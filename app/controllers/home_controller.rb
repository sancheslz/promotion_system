class HomeController < ApplicationController
    def index
    end

    def search
        @results = Promotion.where('name like ?', "%#{params[:q]}%")
    end
end