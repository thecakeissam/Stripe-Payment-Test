#1
require 'sinatra'
require 'stripe'
require 'json'

#2
Stripe.api_key = 'PRIVATE_KEY'


Stripe::Subscription.create(
    :customer => "cus_CyfHilbbZCKqOr",
    :items => [
        {
            :plan => payload[:plan],
            :billing => payload[:billing],
            :amount => payload[:amount],
            :interval => payload[:interval],
            :currency => payload[:currency,
            :usage_type => payload[:usage_type],
        },
    ]
)
#3
get '/' do
  status 200
  return "BadBoyButton back end has been set up correctly"
end

#4
post '/charge' do
  #5
  payload = params
  if request.content_type.include? 'application/json' and params.empty?
    payload = indifferent_params(JSON.parse(request.body.read))
  end

  begin
    #6
    charge = Stripe::Charge.create(
      :amount => payload[:amount],
      :currency => payload[:currency],
      :source => payload[:token],
      :description => payload[:description]
    )
    #7
    rescue Stripe::StripeError => e
    status 402
    return "Error creating charge: #{e.message}"
  end
  #8
  status 200
  return "Charge successfully created"
  

end
