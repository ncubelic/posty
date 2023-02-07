# posty
Code example with unit tests and swiftUI views

App don't use third party dependecies, and this is approach I like to use in real projects. Dependency minimalism.

You will see 2 types of controllers in this example. `PostController` and `PostViewControlle`. *ViewController* is basically ViewController, it manages views
and forwards notifications to it's delegate -> PostController. PostController is used to load data and for app navigation.

## Networking

For networking I use Foundation's URLSession, but I wrote few wrapper classes, and usually I adapt them depending on the project needs

```swift
let networkManager = NetworkManager()
 
var resource = Resource<String>(path: "/path", method: .GET)
resource.queryParameters = [
    URLQueryItem(name: "filter", value: "neostar")
]
networkManager.apiCall(for: resource, completion: handler)
```

```swift
NetworkConfiguration()
```
is place to set default configurations such as timeout interval and default http headers.

`NetworkManager` produces `ErrorReport` which can later be used to write generic Error handler which is not included in the codebase

```swift
Service()
```
`Service` responsibilities are to create the `Resource` which is executed on `NetworkManager`, and forward response to the caller.
In this example, service also decodes API json data to the models. Decoding logic should be improved to use more generic approach.
Option is to move it to `NetworkManager`, but maybe that shouldn't be it's responsibility.


## Layout views in code

1. Use `configure` utility function on any `UIView`.

```swift
private lazy var descriptionLabel = configure(UILabel()) {
  $0.textAlignment = .center
  $0.textColor = .title
  $0.numberOfLines = 0
}
```

2. Add subview

```swift
view.addSubview(descriptionLabel)
```

3. Use ***layout*** utility function to setup constraints.
>
>    No need to set ***translatesAutoresizingMaskIntoConstraints*** = false.

```swift
descriptionLabel.layout(using: [
  descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
  descriptionLabel.widthAnchor.constraint(equalToConstant: 50),
  descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
  descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
])
```
