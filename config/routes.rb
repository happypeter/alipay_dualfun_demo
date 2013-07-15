AlipayDualfunDemo::Application.routes.draw do
  get 'transactions/done'
  post '/checkout' => "transactions#create"
  root :to => 'welcome#index'
end
