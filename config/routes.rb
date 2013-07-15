AlipayDualfunDemo::Application.routes.draw do
  get 'transactions/done'
  post '/checkout' => "transactions#checkout"
  root :to => 'welcome#index'
end
