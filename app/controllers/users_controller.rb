class UsersController < ApplicationController
	skip_before_action:verify_authenticity_token
	def create
		@user = User.new(user_params)
		if @user.save
			@card = Payment.create_stripe_customer_card(@user.stripe_id)
			@charge = Payment.create_on_stripe_charge(@user.plan_id , @user.stripe_id , @card.id )
			@payment = Payment.create(stripe_id:@charge['customer'], payment_transaction_id: @charge['id'] ,payment_type: @charge['payment_method_details']['type']  , status: @charge['status'] , user_id: @user.id ,amount: @charge['amount'])
			@user.update(payment_status: true) if @payment.status == true
			render json: @user, status: :created
		else
			render json: { error: 'There was an error creating the user.' }, status: :unprocessable_entity
		end
	end

	def create_plan
		@plan = Plan.new(ammount: params[:ammount])
		if @plan.save
			render json: @plan, status: :created
		else
			render json: { error: 'There was an error creating the plan.' }, status: :unprocessable_entity
		end
	end



	private
	def user_params
    params.require(:user).permit(:name, :email , :phone_number , :plan_id)
  end

	def card_params
    params.require(:data).permit(:card_number, :card_exp_month , :card_exp_year , :card_cvv)
  end

	
end
