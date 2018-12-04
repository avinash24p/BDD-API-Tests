Feature: sample karate test script

Background:
 * def random_string =
      """
      function(s) {
        var text = "";
        var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        for (var i = 0; i < s; i++)
          text += possible.charAt(Math.floor(Math.random() * possible.length));
        return text;
      }
      """
    * def orderId =  random_string(10)
    * def trackingNo =  random_string(12)
    * def orderItemId =  random_string(11)
    * def reqJson = read('payload.json')
    * print reqJson
    * set reqJson.attributes.orderItems[0].orderItemId = orderItemId
    * set reqJson.attributes.orderItems[0].orderId = orderId
    * print 'created orderid is: ' + orderId


  Scenario: Create order myntra major brand staging
   
    Given header Accesstoken = 'bXludHJhUHJvZE1ham9yOkFjZUAyMjMzIw=='
    Given url "url"
    And request reqJson
    When method post
    Then status 200
    And assert response[0][0].status == 200

  Scenario: Move order in main
    Given url "url"
    When method get
    Then status 200

  Scenario: Tracking number update
  
  * def awbJson = read('awb.json')
  * set awbJson.trackingNumber = 'awb_'+ trackingNo
    Given url 'url'
    And request awbJson
    When method put
    Then status 200
