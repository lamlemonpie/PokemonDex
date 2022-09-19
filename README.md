# PokemonDex
This app presents all existing pokemon with descriptions of their types, sprites and evolutions.

# Overview
This is follows the MVVM structure. The `PokemonClient` class is in charge of defining the methods to call for the GraphQL and Rest APIs. This class exposes publishers as the data is fetched.
The `PokemonViewModel` view model is in charge of calling the `PokemonClient` function in order to fetch the pokemon data and pokemon details both from the ApolloAPI and RestAPI.
The Views only call exposed methods from the view model, they are not awared of the implementations of the client.

# Setup
This app was made with iOS 15.5 as target but tested with iOS 16 and coded in Xcode 14. For the GraphQL queries, these need to be compiled. A build phase has been added for this purpose. Keep in mind an already compiled file is in the project `API.swift`.
The project has an other build phase for SwiftLint. It's required to exclude the `Network/GraphQL` folder to prevent linting in these files due to their compiled nature.

# Screenshots
![Screen Shot 2022-09-19 at 9 00 54 AM](https://user-images.githubusercontent.com/16145739/191035368-ca384962-9fec-40b8-9f40-9efab8213a27.png)
![Screen Shot 2022-09-19 at 9 01 09 AM](https://user-images.githubusercontent.com/16145739/191035438-0e5d98ca-78aa-4796-b714-f6bf11d7ddfe.png)

# Assumptions
- Some styles are ommited in favor of default system styles.

# Technologies
- SwiftUI
- Apollo Client

