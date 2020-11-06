# frozen_string_literal: true

class CrudController < ApplicationController
  def index
    collection
    return unless params[:filter] && params[:filter][:term].present?

    @term = params[:filter][:term]
    @collections = @collections.basic_search(@term)
  end

  def new
    @collection = @klass.new
    session[:back_to] = params[:back_to]
  end

  def edit
    @collection = @klass.find(params[:id])
  end

  def create
    @collection = @klass.new(collection_params)
    if @collection.save
      flash[:notice] = 'Salvo'
      if session[:back_to]
        redirect_to String.new(session[:back_to])
        session[:back_to] = nil
      elsif params[:commit] != 'Salvar'
        redirect_to send("#{@klass.model_name.param_key.pluralize}_path")
      else
        redirect_to send("edit_#{@klass.model_name.param_key}_path", @collection)
      end
    else
      flash[:error] = @collection.errors.full_messages.join('. ')
      render action: 'new'
    end
  end

  def update
    @collection = @klass.find(params[:id])
    if @collection.update(collection_params)
      flash[:notice] = 'Atualizado'
      if params[:commit] == 'Salvar'
        redirect_to send("edit_#{@klass.model_name.param_key}_path", @collection)
      else
        redirect_to send("#{@klass.model_name.param_key.pluralize}_path")
      end
    else
      flash[:error] = @collection.errors.full_messages.join('. ')
      render action: 'edit'
    end
  end

  def destroy
    @collection = @klass.find(params[:id])
    @collection.destroy
    redirect_to send("#{@klass.model_name.param_key.pluralize}_path")
  end

  protected

  def use_klass(klass)
    @klass = klass
  end

  private

  def collection
    @collections ||= @klass.paginate(page: params[:page], per_page: 30).order('created_at desc')
  end
end
