module Condensed exposing (Version, lookUpVersion)


import Array


type alias Version = {
  versionNumber : Int
  , alignmentPatternPositionCenters : List Int
}


lookUpVersion : Int -> Version
lookUpVersion versionNumber =
  Maybe.withDefault emptyVersionData (Array.get (versionNumber - 1) versionData)


emptyVersionData : Version
emptyVersionData =
  {
    versionNumber = 0
    , alignmentPatternPositionCenters = []
  }


versionData : Array.Array Version
versionData =
  Array.fromList [
    {
      versionNumber = 1
      , alignmentPatternPositionCenters = []
    }
    , {
      versionNumber = 2
      , alignmentPatternPositionCenters = [6, 18]
    }
    , {
      versionNumber = 3
      , alignmentPatternPositionCenters = [6, 22]
    }
    , {
      versionNumber = 4
      , alignmentPatternPositionCenters = [6, 26]
    }
    , {
      versionNumber = 5
      , alignmentPatternPositionCenters = [6, 30]
    }
    , {
      versionNumber = 6
      , alignmentPatternPositionCenters = [6, 34]
    }
    , {
      versionNumber = 7
      , alignmentPatternPositionCenters = [6, 22, 38]
    }
    , {
      versionNumber = 8
      , alignmentPatternPositionCenters = [6, 24, 42]
    }
    , {
      versionNumber = 9
      , alignmentPatternPositionCenters = [6, 26, 46]
    }
    , {
      versionNumber = 10
      , alignmentPatternPositionCenters = [6, 28, 50]
    }
    , {
      versionNumber = 11
      , alignmentPatternPositionCenters = [6, 30, 54]
    }
    , {
      versionNumber = 12
      , alignmentPatternPositionCenters = [6, 32, 58]
    }
    , {
      versionNumber = 13
      , alignmentPatternPositionCenters = [6, 34, 62]
    }
    , {
      versionNumber = 14
      , alignmentPatternPositionCenters = [6, 26, 46, 66]
    }
    , {
      versionNumber = 15
      , alignmentPatternPositionCenters = [6, 26, 48, 70]
    }
    , {
      versionNumber = 16
      , alignmentPatternPositionCenters = [6, 26, 50, 74]
    }
    , {
      versionNumber = 17
      , alignmentPatternPositionCenters = [6, 30, 54, 78]
    }
    , {
      versionNumber = 18
      , alignmentPatternPositionCenters = [6, 30, 56, 82]
    }
    , {
      versionNumber = 19
      , alignmentPatternPositionCenters = [6, 30, 58, 86]
    }
    , {
      versionNumber = 20
      , alignmentPatternPositionCenters = [6, 34, 62, 90]
    }
    , {
      versionNumber = 21
      , alignmentPatternPositionCenters = [6, 28, 50, 72, 94]
    }
    , {
      versionNumber = 22
      , alignmentPatternPositionCenters = [6, 26, 50, 74, 98]
    }
    , {
      versionNumber = 23
      , alignmentPatternPositionCenters = [6, 30, 54, 78, 102]
    }
    , {
      versionNumber = 24
      , alignmentPatternPositionCenters = [6, 28, 54, 80, 106]
    }
    , {
      versionNumber = 25
      , alignmentPatternPositionCenters = [6, 32, 58, 84, 110]
    }
    , {
      versionNumber = 26
      , alignmentPatternPositionCenters = [6, 30, 58, 86, 114]
    }
    , {
      versionNumber = 27
      , alignmentPatternPositionCenters = [6, 34, 62, 90, 118]
    }
    , {
      versionNumber = 28
      , alignmentPatternPositionCenters = [6, 26, 50, 74, 98, 122]
    }
    , {
      versionNumber = 29
      , alignmentPatternPositionCenters = [6, 30, 54, 78, 102, 126]
    }
    , {
      versionNumber = 30
      , alignmentPatternPositionCenters = [6, 26, 52, 78, 104, 130]
    }
    , {
      versionNumber = 31
      , alignmentPatternPositionCenters = [6, 30, 56, 82, 108, 134]
    }
    , {
      versionNumber = 32
      , alignmentPatternPositionCenters = [6, 34, 60, 86, 112, 138]
    }
    , {
      versionNumber = 33
      , alignmentPatternPositionCenters = [6, 30, 58, 86, 114, 142]
    }
    , {
      versionNumber = 34
      , alignmentPatternPositionCenters = [6, 34, 62, 90, 118, 146]
    }
    , {
      versionNumber = 35
      , alignmentPatternPositionCenters = [6, 30, 54, 78, 102, 126, 150]
    }
    , {
      versionNumber = 36
      , alignmentPatternPositionCenters = [6, 24, 50, 76, 102, 128, 154]
    }
    , {
      versionNumber = 37
      , alignmentPatternPositionCenters = [6, 28, 54, 80, 106, 132, 158]
    }
    , {
      versionNumber = 38
      , alignmentPatternPositionCenters = [6, 32, 58, 84, 110, 136, 162]
    }
    , {
      versionNumber = 39
      , alignmentPatternPositionCenters = [6, 26, 54, 82, 110, 138, 166]
    }
    , {
      versionNumber = 40
      , alignmentPatternPositionCenters = [6, 30, 58, 86, 114, 142, 170]
    }
  ]
