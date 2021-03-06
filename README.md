# Map search for ground robots 🤖

This project is exploring map generation and path finding algorithms for robots in terrestrial environments. With this objective in mind, we start from the data extracted from a simple odemetric path through an obstacle map, discretise the continuous map, calculate the conditional map, the cost map and find the least cost route or path that the agent has to follow.

## 🗺️ Discrete map

We have made a uniform path over the entire map with Player/Stage and we have run the measurements with the laser sensor, which shows both the path of the agent and the collisions of the sensor with an obstacle or wall.

<p align="center">
  <img src="img/initial_map.png" alt="Initial map">
</p>

To create the obstacle map we traverse the obs object in both X and Y, assigning the sensor readings to the corresponding cell of the new grid and adding 1 if there are readings for that position. For the assignment we use the round function to round to the nearest whole number, the dimensions of the map we have chosen are 50x50.

<p align="center">
  <img src="img/3D_map.png" alt="3D map">
</p>

Below is a 2D representation of the start and end point of a possible route.

<p align="center">
  <img src="img/2D_map.png" alt="2D map">
</p>

### Certainty grid


For the construction of the certainty grid for obstacles and free space, the Bayesian model will be used. This is a method, by which we transform the sensor readings into probabilities and combine them using Bayes' rule. In this way, two probabilities coming from different sensors or from the same sensor at different time instants can be merged.

The probabilities provide a representation of the certainty about a grid[i][j] region, for which P(Occupied|s) and P(Empty|s) are calculated. In this case, to calculate these values, the region in which the reading is located must be taken into account in order to perform the calculations, the equations are as follows:

<p align="center">
  <img src="img/bayes_region.png" alt="Bayes region math">
</p>

In addition, it will be necessary to be able to combine the different readings at other points in time, so that the different observations that have been made will affect the grid. Bayes' rule can be used to calculate the new probability, applying it iteratively where the probability at time tn-1. becomes the a priori probability and is combined with the current observation.

<p align="center">
  <img src="img/bayes.png" alt="Bayes math">
</p>

## 🔠 Cost graph

For the generation of the cost map, the grid created previously will be used as a starting point. For this, the generation of costs by nearest neighbours will be used, in this case the 4 nearest neighbours and the 8 nearest neighbours have been implemented. That is, based on the representation of the world, the costs of all possible paths from the current path to the target are calculated, and then an attempt is made to find the optimal path based on these costs.

The algorithm consists of the following: we start from an initial node whose location in the world is available, and from this initial node we will generate the child nodes which we will store in a list. Following a FiFo policy, the list will be traversed to generate all possible child nodes and the cost of these nodes obtained from the parent node will also be stored.  This will generate the cost map.

## 🚙 Pathfinding

The cost map is nothing more than a graph where we have the cost on each edge of the graph, symbolising the theoretical cost to the agent of moving from one cell to another. Therefore, to find a possible path between the two points we only have to use an algorithm that goes through the structure, for which we have chosen to use the Dijkstra or Branch and Bound algorithm.

### Branch and Bound

The branching and bound algorithm can find the shortest path between two nodes with negative weights, simply by sorting the list by the cumulative cost of the predecessors and current nodes. To improve the search we have implemented two heuristics based on distances: [manhattan](https://en.wikipedia.org/wiki/Taxicab_geometry) and [euclidean](https://en.wikipedia.org/wiki/Euclidean_distance), between the node to be evaluated and the final node.

<p align="center">
  <img src="img/route.png" alt="Route with 8 neighbours">
</p>

## Potential improvements

- [ ] Introduce an [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).
- [ ] Apply [visual SLAM](https://canal.uned.es/video/5cb03918a3eeb0e5468b4567).