class Spree::Admin::DownloadablesController < Spree::Admin::ResourceController
  before_filter :load_data

  create.before :set_viewable
  update.before :set_viewable

  Spree::Admin::DownloadablesController.belongs_to "spree/product", :find_by => "permalink"

  # def create
  #   @downloadable = Spree::Downloadable.new
  #   @downloadable.title = params[:title]
  #   @downloadable.description = params[:descripion]
  #   @downloadable.attachment = params[:attachment]
  # end

  # new_action.after do
  #   respond_to do |wants|
  #     wants.html {render :action => :new, :layout => false}
  #   end
  # end

  # create.after do
  #   respond_to do |wants|
  #     wants.html {redirect_to admin_product_downloadables_url(@product)}
  #   end
  # end

  # create.failure.wants.html do
  #   render :action => :index
  # end

  # update.after do
  #   respond_to do |wants|
  #     wants.html {redirect_to admin_product_downloadables_url(@product)}
  #   end
  # end

  # create.before do
  #   if params[:downloadable].has_key? :viewable_id
  #     if params[:downloadable][:viewable_id] == "All"
  #       object.viewable_type = 'Product'
  #       object.viewable_id = @product.id
  #     else
  #       object.viewable_type = 'Variant'
  #       object.viewable_id = params[:downloadable][:viewable_id]
  #     end
  #   else
  #     object.viewable_type = 'Product'
  #     object.viewable_id = @product.id
  #   end
  # end

  # destroy.before do
  #   @viewable = object.viewable
  # end

  # destroyafter do
  #   respond_to do |wants|
  #     wants.html do
  #       render :text => ""
  #     end
  #   end
  # end

  private

    def load_data
      @product = Spree::Product.find_by_permalink(params[:product_id])
      @variants = @product.variants.collect do |variant|
        [variant.options_text, variant.id ]
      end

      @variants.insert(0, "All")

      @downloadable = Spree::Downloadable.new

      # @download_limits = @product.variants.collect do |variant|
      #   variant.downloadables.empty? ? ("\"#{variant.id}\": \'\'") : ("\"#{variant.id}\": #{variant.downloadables.first.download_limit}")
      # end

      # params[:product_id] = Product.where(:permalink => params[:product_id]).first!.id
    end

    def set_viewable
      if params[:downloadable] && params[:downloadable].has_key?(:viewable_id)
        if params[:downloadable][:viewable_id] == "All"
          @downloadable.viewable_type = 'Product'
          @downloadable.viewable_id = @product.id
        else
          @downloadable.viewable_type = 'Variant'
          @downloadable.viewable_id = params[:downloadable][:viewable_id]
        end
      else
        @downloadable.viewable_type = 'Product'
        @downloadable.viewable_id = @product.id
      end
    end
end