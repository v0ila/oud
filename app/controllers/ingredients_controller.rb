class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]

  # GET /ingredients
  # GET /ingredients.json
  def index
    if params[:search].present?
      @ingredients = Ingredient.near(params[:search], 50, :order => :distance)
    else
      @ingredients = Ingredient.all
    end
      @hash = Gmaps4rails.build_markers(@ingredients) do |ingredient, marker|
        marker.lat ingredient.latitude
        marker.lng ingredient.longitude
        marker.infowindow ingredient.title
        marker.picture({
          "url" => "http://img2.wikia.nocookie.net/__cb20110617061936/ageofempiresonline/images/c/c6/Food.png",
          "width" => 32,
          "height" => 32
          })
        marker.json({ title: ingredient.title}) 
    end
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show
  end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new
  end

  # GET /ingredients/1/edit
  def edit
  end

  # POST /ingredients
  # POST /ingredients.json
  def create
    @ingredient = Ingredient.new(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to @ingredient, notice: 'Ingrediënt toevoegen voltooid' }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredients/1
  # PATCH/PUT /ingredients/1.json
  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to @ingredient, notice: 'Ingrediënt aanpassen voltooid' }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        format.html { render :edit }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to ingredients_url, notice: 'Ingrediënt verwijderd' }
      format.json { head :no_content }
    end
  end

  private
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    def ingredient_params
      params.require(:ingredient).permit(:latitude, :longitude, :address, :description, :title)
    end
end
