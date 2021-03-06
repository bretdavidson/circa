class OrderSubTypesController < ApplicationController

  before_action :set_order_sub_type, only: [
    :show, :edit, :update, :destroy
  ]

  def index
    @order_sub_types = OrderSubType.all.includes(:order_type, :default_location)
    response = { order_sub_types: @order_sub_types.map { |ost| SerializeOrderSubType.call(ost)[:order_sub_type] } }
    render json: response
  end


  def show
    render json: SerializeOrderSubType.call(@order_sub_type)
  end


  def update
    @order_sub_type.update_attributes(order_sub_type_params)
    render json: SerializeOrderSubType.call(@order_sub_type)
  end


  # Load custom concern if present
  begin
    include OrderSubTypesControllerCustom
  rescue
  end


  private


  def order_sub_type_params
    params.require(:order_sub_type).permit(:label, :default_location_id, :default)
  end


  def set_order_sub_type
    @order_sub_type = OrderSubType.find(params[:id])
  end

end
