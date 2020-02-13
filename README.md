# FruitViewer

## Build Stuff:

### CI Build Status (via bitrise):

[![Build Status](https://app.bitrise.io/app/81986c8822c3000a/status.svg?token=Ec6--vgLavmdTqz2HS25Tw&branch=master)](https://app.bitrise.io/app/81986c8822c3000a)

### Build history

https://app.bitrise.io/app/81986c8822c3000a#/builds

### Trello board:
https://trello.com/b/UeFQHbLa/bbc-fruits


### Local builds are done using:
xcode 11.3.1 on
macOSX Catalina 10.15.2
tested locally using iPhoneX and iPad simulators

Project also builds and tests using bitrise CI, using xcode 11.4 nad macOSX Catalina 10.15.3

Some things i wasn't 100 percent sure on in regards to analytics:

- [ ] Assume dont care about measuring time when user goes BACK to a screen
- [ ] Assumed dont care about measuring time when refreshing, since this wasn’t mentioned
- [ ] Assumed event Display is including the network request for example: total time = timeForNetworkRequest+response. Otherwise we are just timing UIKIT?
- [ ] “Finished Drawing on the device” is a bit difficult because UIKit won’t redraw until its next drawing cycle, and then the GPU will render asynchronously from that drawing cycle etc. I chose to log the timings from when a Viewmodel is navigated to, to when the screen is update is requested.

I ran out of time and so didnt implement full crash detection. The app can only report errors (currently reports line number, filename + error message)
