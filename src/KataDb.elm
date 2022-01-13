module KataDb exposing (kataList)

import Set

kataList =
            [ { url =   "https://github.com/emilybache/GildedRose-Refactoring-Kata"
              , tags = Set.fromList [ "MultiLang", "Approvals", "Refactoring" ]
              , title = "Gilded Rose"
              }
            , { url = "https://github.com/emilybache/RPG-Combat-Approval-Kata"
              , tags = Set.fromList [ "Java", "Approvals" ]
              , title = "RPG Combat"
              }
            , { url = "https://github.com/objarni/TestDataBuilderKata"
              , tags = Set.fromList [ "C", "W.I.P" ]
              , title = "Channel - Test Data Builder in C"
              }
            , { url = "https://github.com/objarni/AlarmClockKata"
              , tags = Set.fromList [ "C", "Refactoring" ]
              , title = "Alarm Clock (aka Timer Expiry)"
              }
            , { url = "https://github.com/objarni/Tennis-Refactoring-Kata"
              , tags =
                    Set.fromList
                        [ "C"
                        , "C++"
                        , "C#"
                        , "Golang"
                        , "Java"
                        , "Groovy"
                        , "Refactoring"
                        ]
              , title = "Tennis Score"
              }
            ]
