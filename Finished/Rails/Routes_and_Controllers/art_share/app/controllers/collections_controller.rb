class CollectionsController < ApplicationController
  def index
    collections = Collection.where(user_id: params[:user_id])

    render json: collections
  end

  def create
    new_collection = Collection.new(collection_params)

    if new_collection.save
      render json: new_collection, status: :created
    else
      render json: new_collection.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    collection = Collection.find(params[:id])
    render json: collection
  end

  def destroy
    collection = Collection.find(params[:id])
    collection.destroy
    render json: collection
  end

  def add_artwork
    artwork_collection = ArtworkCollection.new(collection_id: params[:collection_id], artwork_id: params[:artwork_id])

    if artwork_collection.save
      render json: artwork_collection, status: :created
    else
      render json: artwork_collection.errors.full_messages, status: :unprocessable_entity
    end
  end

  def remove_artwork
    artwork_collection = ArtworkCollection.find_by(collection_id: params[:collection_id], artwork_id: params[:artwork_id])
    artwork_collection.destroy

    render json: artwork_collection
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :user_id)
  end
end
