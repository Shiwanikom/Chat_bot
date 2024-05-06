class User < ApplicationRecord
	belongs_to :plan
  	after_create :create_stripe_customer	

	def create_stripe_customer
		byebug
		stripe_customer = Stripe::Customer.create({name: name , email: email , phone: phone_number })
		self.stripe_id = stripe_customer.id
		save
	end	
end
