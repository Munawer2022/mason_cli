mason add --global my_brick --path ./path/to/my_brick
mason list --global
mason remove -g <BRICK_NAME>
mason upgrade --global

# Generate a new brick with hooks.
mason new <BRICK_NAME> --hooks
