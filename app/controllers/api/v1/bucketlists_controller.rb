module Api
  module V1
    class BucketlistsController < ApplicationController
      before_action :set_bucketlist, only: [:show, :update, :destroy]

      # GET /bucketlists
      def index
        @bucketlists = @current_user.bucketlists.get_bucketlist(query_params)
        render json: @bucketlists
      end

      # GET /bucketlists/1
      def show
        render json: @bucketlist
      end

      # POST /bucketlists
      def create
        @bucketlist = @current_user.bucketlists.new(bucketlist_params)
        @bucketlist.created_by = @current_user.id
        if @bucketlist.save
          render json: { message: "Bucketlist successfully created." },
                 status: :created
        else
          render json: @bucketlist.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /bucketlists/1
      def update
        if @bucketlist.update(bucketlist_params)
          render json: { message: "Bucketlist updated!" }, status: 200
        else
          render json: @bucketlist.errors, status: :unprocessable_entity
        end
      end

      # DELETE /bucketlists/1
      def destroy
        @bucketlist.destroy
        head :no_content
      end

      private

      # Only allow a trusted parameter "white list" through.
      def bucketlist_params
        params.permit(:name)
      end

      def query_params
        params.permit(:q, :page, :limit)
      end
    end
  end
end
