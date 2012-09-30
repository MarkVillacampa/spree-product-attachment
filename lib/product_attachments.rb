require 'spree_core'

module ProductAttachments
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_product_attachments'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      Spree::Product.class_eval do
        has_many :downloadables, :as => :viewable, :order => :position, :dependent => :destroy
      end

    end

    config.to_prepare &method(:activate).to_proc
  end
end
