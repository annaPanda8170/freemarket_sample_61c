class ItemsController < ApplicationController
  
  def index
    @categorys = [1, 200, 893, 680]
    @itemCategorys = []
    @categorys.each_with_index do |category_id, i|
      @itemCategorys[i] = []
      @itemCategorys[i] << Category.find(category_id).name
      @items = []
      grandchild_categorys = []
      category = Category.find(category_id)
      category.children.each do |gcc|
        grandchild_categorys << gcc.child_ids
        grandchild_categorys.flatten!
      end
      @items << Item.where(category_id: grandchild_categorys).last(10).reverse
      @items.each do |item|
        @itemCategorys[i] << item
      end
    end
    @brands = [1, 3, 4, 2]
    @item_brands = []
    @brands.each_with_index do |brand, i|
      @item_brands[i] = []
      @item_brands[i] << Brand.find(brand).name
      @items = []
      @items << Item.where(brand_id: brand).last(10).reverse
      @items.each do |item|
        @item_brands[i] << item
      end
    end
  end

  def new
  end

  def update
    # 現状viewからidのvalueを送信出来ないので仮のidを入れています
    @item = Item.where(id: 1)
    @item.update(transaction_status: 0)
    # if @item.update_attribute(:transaction_status, 0)
    #   redirect_to controller: 'products', action: 'show', notice: "出品を停止しました"
    # else
    #   redirect_to controller: 'products', action: 'show', notice: "出品を停止出来ませんでした"  
    # end
  end

  def edit
  end

  def destroy
    @item = Item.find(1)
    @item.destroy
    # if @item.saler_user_id == current_user.id
    #   @item.destroy
    # else
    #   redirect_to controller: 'products', action: 'show', notice: "商品を削除出来ませんでした"
    # end
  end

end
