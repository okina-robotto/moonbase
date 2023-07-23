module Api
  module Status
    class IndexController < Api::Controller
      def index
        render json: { status: :ok }
      end
    end
  end
end
