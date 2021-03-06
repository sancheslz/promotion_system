class Promotion < ApplicationRecord
    validates :name, :code, :discount_rate, :coupon_quantity, :expiration_date, presence: true
    validates :code, uniqueness: { message: 'must be unique' }
    validate :can_updade_code?, on: :update
    validate :can_updade_quantity?, on: :update
    has_many :coupons
    belongs_to :user

    def can_updade_code?
        self.coupons.blank? ? true : errors.add(:code, 'can\'t change the code')
    end

    def can_updade_quantity?
        self.coupons.blank? ? true : errors.add(:coupon_quantity, 'can\'t change the quantity')
    end
    
    def generate_coupons!
        if self.coupons.blank? && self.approved == true
            
            Coupon.transaction do
                
                self.coupons.insert_all(
                    coupon_quantity.times.map do |number| 
                        {
                            :promotion_id => self.id, 
                            :code => "#{self.code}-#{(1 + number).to_s.rjust(4,'0')}",
                            :created_at => Time.now,
                            :updated_at => Time.now
                        }
                    end
                )
                
            end
            true
        else
            false
        end

    end

    def approve!(current_user)
        new_approve(current_user)
    end

    def approved_by
        @approval = PromotionApproval.find_by(promotion: self)
        @approval&.user&.email
    end

    def approved_at
        @approval = PromotionApproval.find_by(promotion: self)
        @approval&.created_at
    end

    private 
    def new_approve(current_user)
        PromotionApproval.create!(
            promotion: self,
            user: current_user,
        )
        self.approved = true
        self.save
    end

end
