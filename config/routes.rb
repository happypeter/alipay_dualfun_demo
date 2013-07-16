AlipayDualfunDemo::Application.routes.draw do
  get 'transactions/done'
  get 'transactions/notify'
  post '/checkout' => "transactions#checkout"
  root :to => 'welcome#index'
end
