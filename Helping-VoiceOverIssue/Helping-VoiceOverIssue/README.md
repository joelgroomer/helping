#  VoiceOver Issue


## From Heather via HWS Slack on Jan 3, 2024

Hey there! I'm helping to update an existing app to add accessibility features. At one point there are a set of NavigationLinks to choose from a few options / steps to take next. Behind the scenes, we navigate and run some code. This was originally accomplished using .onTapGesture on the HStack view that's made to look like a button (not an actual button).
I realized that the tap gesture is ignored when VoiceOver is on. It works if VO is off. I've tried .simultaneousGesture to see if it would work and it also does not work with VO on. I've tested if the extra tap gestures are on the NavLink and on the content "button" in the Navlink... same thing, doesn't work when VO is on.
Simplest version of the code is below. I can find help around the taps, using multiple gestures, and some issues with scrolling/tapping, but I have yet to find any resources specific to it works fine w/o VO but doesn't work with VO.

```swift
struct ContentView: View {

    var body: some View {
        NavigationStack {
                NavigationLink(value: "test") {
                    Text("click here to navigate")
						.simultaneousGesture(TapGesture().onEnded {
                    print("tapped on navlink and 2nd gesture was captured")
                })
			}    
        }
    }
}
```

## My response, Jan 8, 2024

Joel Groomer
did you figure this out? I got it to work with an accessibilityAction modifier, but a level higher than may have been expected.

```swift
struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                AnotherView()
            } label: {
                Text("Tap here to navigate")
                    // works when VO is off
                    .simultaneousGesture(TapGesture().onEnded {
                        print("tapped and 2nd gesture captured")
                    })
            }
            .accessibilityAction {
                // works when VO is on
                print("VO selected btn")
            }
        }
    }
}
```

not exactly sure how to apply it to your HStack situation without seeing it, but hopefully that helps
