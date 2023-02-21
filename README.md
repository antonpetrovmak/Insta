# Insta (the test task)
Summary: Create an application visually similar in appearance and behavior to Instagram.

Time spent: 4h

Requvirenments:
- One screen built on UICollectionView or SwiftUI
- Above (where stories) is a list of users (https://reqres.in/api/users). Horizontal scroll, without support for taps on cells. In the cell, display the fields "first_name", "last_name" and the avatar by the link from the "avatar" field
- Below it is a list of resources (https://reqres.in/api/unknown). Vertical scroll, without support for taps on cells. In the resource cell, show the "name" field from JSON, fill the place under the photo with the color from the "color" field, fixed cell height.
When scrolling down, stories should scroll along with resources (not pinned to top)
- Design a CoreData base to store users and resources. At the first launch, the application must download the data from the API and save it to the CoreData database. UI shows data from database
- Optional task (if time permits): pagination support for resources - https://reqres.in/api/unknown?page=X
- Language - Swift 5+
- You can use any libraries you know
- Using new classes (like Combine/DiffableDataSource from iOS13+ is welcome)
- You choose the application architecture (or lack of it), be prepared to defend your choice in the interview. A working app is a priority over beautiful architecture.

## Demo
![Simulator Screen Recording - iPhone 14 Pro - 2023-02-14 at 18 26 33](https://user-images.githubusercontent.com/15180933/219120510-ea433939-b776-44a1-800d-e1a943cb2226.gif)
