module Admin
  class HomeController < Admin::ApplicationController
    expose(:resource) { :home }
  end
end
