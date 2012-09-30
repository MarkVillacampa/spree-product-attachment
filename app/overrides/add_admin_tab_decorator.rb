Deface::Override.new(:virtual_path => "spree/admin/products/edit",
                     :name => "print_buttons",
                     :insert_after => "[data-hook='admin_product_tabs']",
                     :partial => "admin/shared/product_downloadables_tab",
                     :disabled => false)