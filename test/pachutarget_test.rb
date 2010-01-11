require File.join(File.dirname(__FILE__), '../pachutarget.rb')
require "test/unit"
require "rack/test"

class PachuTargetTest < Test::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
  
  def test_get_index
    get '/'
    assert_equal 'Pachube Target Handling Service', last_response.body
  end
  
  def test_post_to_api
    json = '{
        "environment": {
          "description": "",
          "feed": "http:\/\/www.pachube.com\/api\/feeds\/343",
          "id": 343,
          "location": {
            "lat": 55.74479,
            "lng": -3.18157,
            "name": "location description"
          },
          "title": "test feed yes"
        },
        "id": 1,
        "threshold_value": 9.0,
        "timestamp": "2009-09-07T12:16:02Z",
        "triggering_datastream": {
          "id": "0",
          "url": "http:\/\/www.pachube.com\/api\/feeds\/343\/datastreams\/0",
          "value": {
            "current_value": "9.07624035140473",
            "max_value": 9.99650150341,
            "min_value": 0.00471012639984
        }
      },
       "type": "gte",
       "url": "http:\/\/www.pachube.com\/api\/triggers\/1"
      }'
    
    post '/api/v1', {:body => json}
  end
  
end