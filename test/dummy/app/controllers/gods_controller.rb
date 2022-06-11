# frozen_string_literal: true

class GodsController < ApplicationController
  before_action :set_god, only: [:show, :edit, :update, :destroy]

  # GET /gods
  def index
    @gods = God.all
  end

  # GET /gods/1
  def show; end

  # GET /gods/new
  def new
    @god = God.new
  end

  # GET /gods/1/edit
  def edit; end

  # POST /gods
  def create
    @god = God.new(god_params)

    if @god.save
      redirect_to @god, notice: 'God was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /gods/1
  def update
    if @god.update(god_params)
      redirect_to @god, notice: 'God was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /gods/1
  def destroy
    @god.destroy
    redirect_to gods_url, notice: 'God was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_god
    @god = God.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def god_params
    params.fetch(:god, {})
  end
end
