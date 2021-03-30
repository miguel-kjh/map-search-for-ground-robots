# Map search for ground robots 🤖

This project is exploring map generation and path finding algorithms for robots in terrestrial environments. With this objective in mind, we start from the data extracted from a simple odemetric path through an obstacle map, discretise the continuous map, calculate the conditional map, the cost map and find the least cost route or path that the agent has to follow.

## 🗺️ Discrete map

We have made a uniform path over the entire map with Player/Stage and we have run the measurements with the laser sensor, resulting in the map in figure 1, which shows both the path of the agent and the collisions of the sensor with an obstacle or wall.

Para crear el mapa de obstáculos recorremos el objeto obs tanto en X como en Y asignando las lecturas del sensor a la celda correspondiente de la nueva rejilla y sumándole 1 si existen lecturas para esa posición. Para la asignación utilizamos la función round  para redondear al número entero más cercano, las dimensiones del mapa que hemos elegido han sido de 25x25.

### 🧮 Certainty grid


For the construction of the certainty grid for obstacles and free space, the Bayesian model will be used. This is a method, by which we transform the sensor readings into probabilities and combine them using Bayes' rule. In this way, two probabilities coming from different sensors or from the same sensor at different time instants can be merged.

The probabilities provide a representation of the certainty about a grid[i][j] region, for which P(Occupied|s) and P(Empty|s) are calculated. In this case, to calculate these values, the region in which the reading is located must be taken into account in order to perform the calculations, the equations are as follows:

In addition, it will be necessary to be able to combine the different readings at other points in time, so that the different observations that have been made will affect the grid. Bayes' rule can be used to calculate the new probability, applying it iteratively where the probability at time ![](https://latex.codecogs.com/gif.latex?t_{n-1}). becomes the a priori probability and is combined with the current observation.

```math
SE = \frac{\sigma}{\sqrt{n}}
```


## 🔠 Cost graph

## 🚙 Pathfinding

## Potential improvements