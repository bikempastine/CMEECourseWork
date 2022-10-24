# An example utility function
# This functiom calculates heights of trees given the distance of each tree
# from its base and angle to its top, using trigonometric formula

# height = distance * tan(radians)

# Arguments=
# degrees: the angle of elevation of the tree
# distance: The distance from the base of the tree (meters)

# Output=
# The heights of the tree, same units as the distance argument

TreeHeight <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    print(paste("Tree height is:", height))
    print(paste("Tree height is:", height))

    # return (height)
}

TreeHeight(37, 40)