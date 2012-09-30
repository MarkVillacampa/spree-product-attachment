Deface::Override.new(:virtual_path => "spree/admin/shared/product_tabs",
                     :name => "attachments_download_tab",
                     :insert_after => "[data-hook='admin_product_tabs']",
                     :partial => "admin/shared/product_downloadables_tab",
                     :disabled => false)