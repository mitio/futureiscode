class HomeController < ApplicationController
  def index
    render text: RUBY_VERSION
  end
end
