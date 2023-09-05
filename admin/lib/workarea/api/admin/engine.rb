module Workarea
  module Api
    module Admin
      class Engine < ::Rails::Engine
        include Workarea::Plugin
        isolate_namespace Workarea::Api::Admin

        # Depending on plugin loading order, to_prepare may cause an autoload of
        # {ApplicationDocument}s so make sure we add this dependency before
        # `config.to_prepare`
        initializer 'workarea.api.admin.date_filtering' do
          Workarea::ApplicationDocument.include(DateFiltering)
        end

        config.after_initialize do
          Workarea::Api::Admin::Swagger.generate!
        end

        config.to_prepare do
          raise "GOT HERE"
          ApplicationDocument.include(DateFiltering)
        end
      end
    end
  end
end
