# Request Schema #

        {"baseInfo": {
              "appInfo":{
                  "bundleID":"com.attinad",
                  "bundleName":"",
                  "bundleVersion":"1.0"
              },
              "deviceInfo":{
                  "deviceID":"AC989193-9E95-44B8-825D-14D5789C24DC",
                  "platform":"iOS",
                  "version":"8.1"
              },
              "libInfo":{
                  "libVersion":"0.0.1"
              }
        },
        "screenViews":[{
            "screenViewID":"",
            "presentScreen":"Details screen",
            "previousScreen":"Listing screen",
            "screenWatchedTime":"Timestamp",
            "screenWatchDuration":"milliseconds",
            "onScreenActions":[{
                  "eventType":"ButtonAction",
                  "eventName":"viewSeriesList",
                  "eventStartTime":"timestamp",
                  "eventDuration":"milliseconds",
                  "dataURL":"",
                  "customParam":{
                      "anykey":"anyvalue"
                  },
                  "location":{
                      "latitude":"0",
                      "longitude":"0"
                  }
            },{
                "eventType":"DataLoad",
                "eventName":"loadSeriesList",
                "eventStartTime":"timestamp",
                "eventDuration":"milliseconds",
                "dataURL":"",
                "customParam":{
                    "anykey":"anyvalue"
                },
                "location":{
                    "latitude":"0",
                    "longitude":"0"
                }
        }],
        "location":{
            "latitude":"0",
            "longitude":"0"
        }
      }]}

# Response Schema #

        {"syncedObjects":[
                {"screenViewID":"id1"},
                {"screenViewID":"id2"},
                {"screenViewID":"id3"}
        ],
        "lastSync":"date"
        }
