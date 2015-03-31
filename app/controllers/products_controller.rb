class ProductsController < ApplicationController
  require 'pusher'
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /products
  # GET /products.json
  def index
    where_clause = {}
    where_clause.merge! ratings: params[:ratings] if params[:ratings]
    @products = Product.search(
        params[:query] || '*' ,
        where: where_clause,
        limit: 10,
        suggest: true,
        facets: [:ratings],
        smart_facets: true,
        page: params[:page],
        order: {_score: :desc}
    )
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # GET /products/1/buy
  def buy
    @product = Product.find params[:id]
    updated = @product.update quantity: (@product.quantity - 1)
    if updated
      Pusher['product_notifications_channel'].trigger('product_notifications_event', {
        id: @product.id,
        message: "Just bought '#{@product.name}'!!",
        user: current_user.email.match(/^(.*)@/)[1],
        color: 'red',#@chat.user.color,
        created_at: current_user.created_at.strftime("%I:%M%p")
      })
    end
    render nothing: true
  end

  # GET /products/1/watch
  def watch
    current_user.watchlists << Product.find(params[:id])
    render nothing: true
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :company_id, :price, :description, :quantity, :image)
    end
end
