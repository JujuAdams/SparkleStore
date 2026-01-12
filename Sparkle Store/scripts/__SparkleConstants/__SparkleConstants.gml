// Feather disable all

#macro SPARKLE_VERSION  "1.1.1"
#macro SPARKLE_DATE     "2026-01-12"

///////
// Status
///////

// The operation was cancelled.
#macro SPARKLE_STATUS_CANCELLED  -2

// The operation was reported to have failed by GameMaker.
#macro SPARKLE_STATUS_FAILED  -1

// THe operation has been queued and has not yet started.
#macro SPARKLE_STATUS_QUEUED  0

// The operation has started and we are waiting for it to complete.
#macro SPARKLE_STATUS_PENDING  0.1

// The operation completed successfully.
#macro SPARKLE_STATUS_SUCCESS  1

///////
// Priority
///////

// The operation will be added to the back of the queue and will be dispatched when prior
// operations have completed.
#macro SPARKLE_PRIORITY_NORMAL  0

// The operation will be added to the front of the queue and will be dispatched at the nearest
// opportunity ahead of enqueued operations.
#macro SPARKLE_PRIORITY_HIGH  1

// The operation will be dispatched immediately, ignoring any save/load rate limits.
#macro SPARKLE_PRIORITY_IMMEDIATE  2

///////
// Other
///////

#macro SPARKLE_RUNNING_FROM_IDE  (GM_build_type == "run")
                            
#macro SPARKLE_ON_WINDOWS   (os_type == os_windows)
#macro SPARKLE_ON_MAC       (os_type == os_macosx)
#macro SPARKLE_ON_LINUX     (os_type == os_linux)
#macro SPARKLE_ON_SWITCH    (os_type == os_switch)
#macro SPARKLE_ON_PS4       (os_type == os_ps4)
#macro SPARKLE_ON_PS5       (os_type == os_ps5)
#macro SPARKLE_ON_XBOX      ((os_type == os_xboxone) || (os_type == os_xboxseriesxs))
#macro SPARKLE_ON_ANDROID   (os_type == os_android)
#macro SPARKLE_ON_IOS       (os_type == os_ios)

#macro SPARKLE_ON_PS_ANY   (SPARKLE_ON_PS4 || SPARKLE_ON_PS5)
#macro SPARKLE_ON_CONSOLE  (SPARKLE_ON_SWITCH || SPARKLE_ON_PS_ANY || SPARKLE_ON_XBOX)
#macro SPARKLE_ON_MOBILE   (SPARKLE_ON_ANDROID || SPARKLE_ON_IOS)
#macro SPARKLE_ON_DESKTOP  (SPARKLE_ON_WINDOWS || SPARKLE_ON_MAC || SPARKLE_ON_LINUX)

#macro SPARKLE_OP_SAVE    0
#macro SPARKLE_OP_LOAD    1
#macro SPARKLE_OP_DELETE  2