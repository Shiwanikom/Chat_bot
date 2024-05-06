class Payment < ApplicationRecord
  belongs_to :user

  def self.get_token
    Stripe::Token.create({
        card: {
        number: "4242424242424242",
        exp_month: 5 ,
        exp_year: 2024,
        cvc: "314",
      
      }
    })
  end

  def self.create_stripe_customer_card(stripe_customer)
    token = get_token
      Stripe::Customer.create_source(
              stripe_customer,
              {source: token.id}
          )
  end

  def self.create_on_stripe_charge(amount, stripe_customer_id, card_id)
    Stripe::Charge.create(
        amount: amount*100,
        currency: 'usd',
        source: card_id,
        customer: stripe_customer_id,
        description: "Account $ #{amount} Charge"
      )
  end
end
