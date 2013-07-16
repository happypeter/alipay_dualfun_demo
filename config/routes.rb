AlipayDualfunDemo::Application.routes.draw do
  get 'transactions/done'
  post 'transactions/notify'
  post '/checkout' => "transactions#checkout"
  root :to => 'welcome#index'
end
