require 'rails_helper'

describe "Cars API" do
  describe 'GET /cars' do
    it "returns a list of cars" do
      ford = create_make(name: "Ford")
      taurus = create_car(
        make_id: ford.id,
        color: "red",
        doors: 2,
        purchased_on: "1973-10-04"
      )
      subaru = create_make(name: "Subaru")
      outback = create_car(
        make_id: subaru.id,
        color: "blue",
        doors: 4,
        purchased_on: "1973-10-04"
      )

      get '/cars', {}, {'Accept' => 'application/json'}

      expected_response = {
        "_links" => {
          "self" => {"href" => cars_path},
        },
        "_embedded" => {
          "cars" => [
            {
              "_links" => {
                "self" => {"href" => car_path(taurus)},
                "make" => {"href" => make_path(ford)}

              },
              "id" => taurus.id,
              "color" => taurus.color,
              "doors" => taurus.doors,
              "purchased_on" => taurus.purchased_on.strftime("%a, %d %b %Y")
            },
            {
              "_links" => {
                "self" => {"href" => car_path(outback)},
                "make" => {"href" => make_path(subaru)}

              },
              "id" => outback.id,
              "color" => outback.color,
              "doors" => outback.doors,
              "purchased_on" => outback.purchased_on.strftime("%a, %d %b %Y")
            }


          ]
        }
      }
      expect(response.code.to_i).to eq 200
      expect(JSON.parse(response.body)).to eq(expected_response)
    end
  end
  describe 'GET /cars' do
    it "returns one car" do
      ford = create_make(name: "Ford")
      taurus = create_car(
        make_id: ford.id,
        color: "red",
        doors: 2,
        purchased_on: "1973-10-04"
      )

      get "/cars/#{taurus.id}", {}, {'Accept' => 'application/json'}

      expected_response = {
        "_links" => {
          "self" => {"href" => car_path(taurus)},
          "make" => {"href" => make_path(ford)}
        },
        "id" => taurus.id,
        "color" => "red",
        "doors" => 2,
        "purchased_on" => taurus.purchased_on.strftime("%a, %d %b %Y")
      }

      expect(response.code.to_i).to eq 200
      expect(JSON.parse(response.body)).to eq(expected_response)
    end
  end
end