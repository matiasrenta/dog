class Dev::CatalogCleanersController < ApplicationController
  # la opcion class: 'CatalogCleaner' es para que no intente con Dev::CatalogCleaner
  load_resource except: :index, param_method: :catalog_cleaner_params, class: 'CatalogCleaner'
  authorize_resource param_method: :catalog_cleaner_params, class: 'CatalogCleaner'

  def index
    set_content_title(nil, ['Catalog Cleaners'])
  end

  def run_cleaner
    eval("CatalogCleaner.#{params[:catalog_cleaner][:cleaner]}")
    redirect_to dev_catalog_cleaners_path, notice: "Done!"
  end

end
