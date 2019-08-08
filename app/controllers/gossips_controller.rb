class GossipsController < ApplicationController

  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find_by(id: params['id'])
  end

  def new
    @tags = Tag.all
  end

  def create
    tags = Tag.where(id: params[:tags])
    @gossip = Gossip.new(title: params[:title], content: params[:content])
    # @gossip.user = current_user
    @gossip.user = User.last
    @gossip.tags << tags
    if @gossip.save
      flash[:success] = "Potin bien créé !"
      redirect_to gossips_path
    else
      render :new
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    gossip_params = params.require(:gossip).permit(:title, :content)
    @gossip.update(gossip_params)
    redirect_to gossips_path
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to gossips_path
  end
end
