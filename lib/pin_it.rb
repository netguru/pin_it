require "pin_it/version"
begin
  require "active_support/core_ext/object/to_query"
rescue LoadError
  require "active_support/core_ext/object/conversions"
end

module PinIt
  module Helper
    def pin_it_button(options = {})
      query_params = options.slice(:url, :media, :description)
      img = tag :img, :src => "//assets.pinterest.com/images/PinExt.png", :title => "Pin It", :border => "0"
      content_tag :a, img, "href" => "#",
                                "onClick" => "PinWindow=window.open('http://pinterest.com/pin/create/button/?#{query_params.to_query}','PinWindow','width=800, height=600'); return false;",
                                "class" => "pin-it-button",
                                "count-layout" => "vertical"
    end

    def pin_it_js
      IO.read(File.expand_path("../../vendor/assets/javascripts/pin_it.js", __FILE__))
    end
  end

  if defined? ::Rails::Railtie
    class Railtie < ::Rails::Railtie
      initializer "pin_it.view_helpers" do |app|
        ::ActionView::Base.send :include, PinIt::Helper
      end
    end
  end

  if defined? ::Rails::Engine
    module Rails
      class Engine < ::Rails::Engine
      end
    end
  end
end
