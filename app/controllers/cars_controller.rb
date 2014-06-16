class CarsController < ActionController::Base
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
  end

  def create
    json_params = JSON.parse(request.body.read)
    @car = Car.create!(
      make_id: json_params["make_id"],
      color: json_params["color"],
      doors: json_params["doors"],
      purchased_on: json_params["purchased_on"]
    )

    render 'show', :status => 201
  end
end