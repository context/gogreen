ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.forgot_password '/forgot_password', :controller => 'passwords', :action => 'new'
  map.change_password '/change_password/:reset_code', :controller => 'passwords', :action => 'reset'
  
  # Restful Authentication Resources
  map.resources :users
  map.resources :passwords
  map.resource :session

  map.resources :contests do |contest|
    contest.resources :pledges
  end
  map.resources :pledges, :has_many => :reports
  map.resources :mails
  map.resources :reports
  map.resources :teams, :has_many => :pledges
  map.resource :reminder_email
  map.tell_a_friend 'tell_a_friend', :controller => 'tell_a_friend', :action => 'create'
  map.opt_out 'opt_out/:code', :controller => 'opt_out', :action => 'create'

  map.resources :companies
  map.resources :industries
  # Home Page
  map.root :contests

  map.namespace :admin do |admin|
    admin.resources :pledges, :has_many => :report_reminders
    admin.resources :users
  end

  map.connect '/admin', :controller => 'admin/pledges'

  #map.admin '/odmin', :pledges, :namespace => 'admin'
end
