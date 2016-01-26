module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_bucketlist
      before_action :set_item, only: [:show, :update, :destroy]

      # GET /items
      def index
        @items = @bucketlist.items.order(id: :desc)

        render json: @items
      end

      # GET /items/1
      def show
        render json: @item
      end

      # POST /items
      def create
        @item = @bucketlist.items.new(item_params)

        if @item.save
          render json: @item, status: :created
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /items/1
      def update
        if @item.update(item_params)
          render json: @item, status: 200
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      # DELETE /items/1
      def destroy
        @item.destroy
        head :no_content
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_item
        @item = @bucketlist.items.find_by_id(params[:id])
        if @item.blank?
          msg = "Item with id:#{params[:id]} doesnt exist in this bucketlist"
          msg = { error: msg }
          render json: msg, status: :unprocessable_entity
        end
      end

      # Only allow a trusted parameter "white list" through.
      def item_params
        params.permit(:name, :done, :bucketlist_id)
      end
    end
  end
end
