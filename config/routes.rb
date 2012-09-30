Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :products do
      resources :downloadables
    end
  end

  # Add your extension routes here
end