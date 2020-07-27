class VehicleQuery
  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  def call(params)
    scoped = @initial_scope
    scoped = search(scope, params[:search]) if params[:search]
    scoped = filter_by_price(scoped, params[:from_price], params[:to_price]) if params[:from_price] || params[:to_price]
    scoped = filter_by_colour(scoped, params[:colour]) if params[:colour]
    scoped = filter_by_make(scoped, params[:make_from], params[:make_to]) if params[:make_from] || params[:make_to]
    scoped = sort(scoped, params[:sort_on], params[:sort_by]) if params[:sort_on] || params[:sort_by]
    scoped
  end

  private

  def search(scoped, query = nil)
    scoped.where("name LIKE ?", "%#{query}%")
  end

  def filter_by_price(scoped, from_price = nil, to_price = nil)
    scoped = from_price ? scoped.where('price > ?', from_price.to_i) : scoped
    to_price ? scoped.where('price < ?', to_price.to_i) : scoped
  end

  def filter_by_colour(scoped, colour = nil)
    colour ? scoped.where('LOWER(colour) = ? ', colour.downcase) : scoped
  end

  def filter_by_make(scoped, make_from = nil, make_to = nil)
    scoped = make_from ? scoped.where('make > ?', make_from.to_i) : scoped
    make_to ? scoped.where('make < ?', make_to.to_i) : scoped
  end

  def sort(scoped, sort_on = :price, sort_by = :desc)
    sort_by ||= :desc
    scoped.order(sort_on => sort_by)
  end
end