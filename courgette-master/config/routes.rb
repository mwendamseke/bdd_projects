unless Rails.env.production?

  ActionController::Routing::Routes.draw do |map|
    map.resources :features, :only => 'index'
    map.feature_view "/features/view", :controller => 'features', :action => 'view'
    map.feature_source "/features/source", :controller => 'features', :action => 'source'
    map.treeview "/features/treeview", :controller => 'features', :action => 'treeview'
  end

end