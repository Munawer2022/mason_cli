## Project Structure

```
.
   ├── ...
   ├── config                       
   │   ├── navigation             # This folder contains global modules and styling
   │   ├── network                # This folder contains images and the *data.json*
   |   └── theme                  # Contains all the individual pages (home, tabs, category, list, single-item)
   |── core                       # Contains the item-api service that retrieves data from the JSON file
   |   └── utils                  # The global SCSS variables to use throughout the app
   |── data                       # A config file to make TypeScript objects available in intellisense
   |   ├── data sources           # The root index app file - This launches the app
   |   ├── models                 # Metadata for the app
   │   └── repositories           # Cache configurations
   ├── domain                       
   │   ├── entities               # This folder contains global modules and styling
   │   ├── failure                # This folder contains images and the *data.json*
   │   ├── repositories           # This folder contains images and the *data.json*
   |   └── use cases              # Contains all the individual pages (home, tabs, category, list, single-item)
   ├── features                       
   │   ├── cubit                  # This folder contains global modules and styling
   │   ├── initial params         # This folder contains images and the *data.json*
   │   ├── navigator              # This folder contains images and the *data.json*
   │   ├── page                   # This folder contains images and the *data.json*
   |   └── state                  # Contains all the individual pages (home, tabs, category, list, single-item)
   └── ...
```



mason add --global my_brick --path ./path/to/my_brick

//like that

// ./path/to/my_brick

// C:\Users\amazo\Downloads\mason_tdd\mason_tdd

mason list --global

mason remove -g <BRICK_NAME>

mason upgrade --global

# Generate a new brick with hooks.
mason new <BRICK_NAME> --hooks
