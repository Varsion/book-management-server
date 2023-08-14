class IndexController < ApplicationController
  def index
    render json: {
      message: "Develop by Jianhua, Build & Deploy by RENDER",
    }, status: 200
  end
end
