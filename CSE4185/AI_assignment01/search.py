###### Write Your Library Here ###########
from collections import deque
from queue import PriorityQueue

#########################################


def search(maze, func):
    return {
        "bfs": bfs,
        "astar": astar,
        "astar_four_circles": astar_four_circles,
        "astar_many_circles": astar_many_circles,
    }.get(func)(maze)


# -------------------- Stage 01: One circle - BFS Algorithm ------------------------ #


def track_path(path, start_point, r, c, visited):
    while start_point != (r, c):
        path.append((r, c))
        r, c = visited[r][c]
    path.append(start_point)

    path = path[::-1]


def bfs(maze):
    """
    [문제 01] 제시된 stage1의 맵 세가지를 BFS Algorithm을 통해 최단 경로를 return하시오.(20점)
    """
    start_point = maze.startPoint()

    path = []

    ####################### Write Your Code Here ################################

    # init
    visited = [[()] * maze.cols for _ in range(maze.rows)]
    r, c = start_point
    visited[r][c] = (0, 0)
    queue = deque(start_point)

    while queue:
        r = queue.popleft()
        c = queue.popleft()

        if maze.isObjective(r, c):
            break

        neighbors = maze.neighborPoints(r, c)

        for neighbor in neighbors:
            nr = neighbor[0]
            nc = neighbor[1]

            if not visited[nr][nc]:
                visited[nr][nc] = (r, c)
                queue += (nr, nc)

    track_path(path, start_point, r, c, visited)

    return path

    ############################################################################


class Node:
    def __init__(self, parent, location, obj):
        self.parent = parent
        self.location = location  # 현재 노드

        self.obj = obj[:]

        # F = G+H
        self.f = 0
        self.g = 0
        self.h = 0

    def __eq__(self, other):
        return self.location == other.location and self.obj == other.obj

    def __le__(self, other):
        return self.f <= other.f

    def __lt__(self, other):
        return self.f < other.f

    def __gt__(self, other):
        return self.f > other.f

    def __ge__(self, other):
        return self.f >= other.f


# -------------------- Stage 01: One circle - A* Algorithm ------------------------ #


def manhatten_dist(p1, p2):
    return abs(p1[0] - p2[0]) + abs(p1[1] - p2[1])


def astar(maze):

    """
    [문제 02] 제시된 stage1의 맵 세가지를 A* Algorithm을 통해 최단경로를 return하시오.(20점)
    (Heuristic Function은 위에서 정의한 manhatten_dist function을 사용할 것.)
    """

    start_point = maze.startPoint()

    end_point = maze.circlePoints()[0]

    path = []

    ####################### Write Your Code Here ################################

    start_node = Node(None, start_point, [])
    end_node = Node(None, end_point, [])

    open_list = []
    closed_list = []

    open_list.append(start_node)

    while open_list:
        current_node = open_list[0]
        current_idx = 0

        for idx, open_node in enumerate(open_list):
            if open_node < current_node:
                current_node = open_node
                current_idx = idx

        open_list.pop(current_idx)
        closed_list.append(current_node)

        if current_node == end_node:
            end_node = current_node
            break

        neighbors = maze.neighborPoints(current_node.location[0], current_node.location[1])

        children = []
        for neighbor in neighbors:
            new_node = Node(current_node, neighbor, [])
            children.append(new_node)

        for child in children:
            if child in closed_list:
                continue

            child.g = current_node.g + 1
            child.h = manhatten_dist(child.location, end_node.location)
            child.f = child.g + child.h

            flag = False
            for open_node in open_list:
                if child.location == open_node.location and child > open_node:
                    flag = True
            if flag:
                continue

            open_list.append(child)

    current_node = end_node
    while current_node is not None:
        path.append(current_node.location)
        current_node = current_node.parent

    return path[::-1]

    ############################################################################


# -------------------- Stage 02: Four circles - A* Algorithm  ------------------------ #


def get_dist(cur_len, max_len, obj, visited, dist):
    if cur_len == max_len:
        sum = 0
        for i in range(1, max_len):
            sum += dist[visited[i]][visited[i - 1]]
        return sum

    ret = 0
    for cur_idx in range(max_len):
        if cur_idx in visited:
            continue

        visited[cur_idx] = cur_idx
        ret = min(ret, get_dist(cur_len + 1, max_len, obj, visited, dist))
        visited[cur_idx] = -1

    return ret


def stage2_heuristic(current, dist):
    obj = current.obj
    max_len = len(obj)
    visited = [False] * max_len
    ret = 0

    for cur_idx in range(max_len):
        visited[cur_idx] = cur_idx
        ret = min(
            ret,
            manhatten_dist(current.location, obj[cur_idx])
            + get_dist(1, max_len, obj, visited, dist),
        )

    return ret


def astar_four_circles(maze):
    """
    [문제 03] 제시된 stage2의 맵 세가지를 A* Algorithm을 통해 최단 경로를 return하시오.(30점)
    (단 Heurstic Function은 위의 stage2_heuristic function을 직접 정의하여 사용해야 한다.)
    """

    end_points = maze.circlePoints()
    end_points.sort()

    path = []

    ####################### Write Your Code Here ################################

    start_point = maze.startPoint()
    dist = [[0] * 4 for _ in range(4)]
    for i in range(4):
        for j in range(4):
            dist[i][j] = manhatten_dist(end_points[i], end_points[j])

    start_node = Node(None, start_point, end_points)

    open_list = []
    open_list.append(start_node)
    closed_list = []

    while open_list:
        current_node = open_list[0]
        current_idx = 0

        for idx, open_node in enumerate(open_list):
            if open_node < current_node:
                current_node = open_node
                current_idx = idx

        open_list.pop(current_idx)
        if current_node in closed_list:
            continue
        closed_list.append(current_node)

        if current_node.location in current_node.obj:
            current_node.obj.remove(current_node.location)

        if not current_node.obj:
            break

        neighbors = maze.neighborPoints(current_node.location[0], current_node.location[1])

        for neighbor in neighbors:
            new_node = Node(current_node, neighbor, current_node.obj)

            if new_node in closed_list:
                continue

            new_node.g = current_node.g + 1
            new_node.h = stage2_heuristic(new_node, dist)
            new_node.f = new_node.g + new_node.h
            new_node.obj = current_node.obj[:]

            if new_node in open_list:
                continue

            open_list.append(new_node)

    while current_node is not None:
        path.append(current_node.location)
        current_node = current_node.parent

    return path[::-1]

    ############################################################################


# -------------------- Stage 03: Many circles - A* Algorithm -------------------- #


def find(parent, u):
    if u != parent[u]:
        parent[u] = find(parent, parent[u])
    return parent[u]


def union(parent, u, v):
    u = find(parent, u)
    v = find(parent, v)
    parent[v] = u


def mst(loc, obj):

    cost_sum = 0
    ####################### Write Your Code Here ################################
    parent = [0]
    edge = []
    n = len(obj)
    cnt = 0

    for i in range(n):
        for j in range(i):
            edge.append((manhatten_dist(obj[i], obj[j]), i + 1, j + 1))
        edge.append((manhatten_dist(obj[i], loc), i + 1, 0))
    edge.sort()

    for i in range(1, n + 1):
        parent.append(i)

    while True:
        if cnt == n - 1:
            break
        d, u, v = edge.pop(0)
        if find(parent, u) == find(parent, v):
            continue
        union(parent, u, v)
        cost_sum += d
        cnt += 1

    return cost_sum

    ############################################################################


def stage3_heuristic(loc, obj):
    return mst(loc, obj)


def astar_many_circles(maze):
    """
    [문제 04] 제시된 stage3의 맵 세가지를 A* Algorithm을 통해 최단 경로를 return하시오.(30점)
    (단 Heurstic Function은 위의 stage3_heuristic function을 직접 정의하여 사용해야 하고, minimum spanning tree
    알고리즘을 활용한 heuristic function이어야 한다.)
    """

    end_points = maze.circlePoints()
    end_points.sort()

    path = []

    ####################### Write Your Code Here ################################

    start_point = maze.startPoint()
    start_node = Node(None, start_point, end_points)

    pq = PriorityQueue()
    pq.put(start_node)
    closed_list = []

    while pq:
        current_node = pq.get()

        if current_node in closed_list:
            continue

        closed_list.append(current_node)

        if current_node.location in current_node.obj:
            current_node.obj.remove(current_node.location)

        if not current_node.obj:
            break

        neighbors = maze.neighborPoints(current_node.location[0], current_node.location[1])

        for neighbor in neighbors:
            new_node = Node(current_node, neighbor, current_node.obj)

            if new_node in closed_list:
                continue

            new_node.g = current_node.g + 1
            new_node.h = stage3_heuristic(new_node.location, current_node.obj)
            new_node.f = new_node.g + new_node.h
            new_node.obj = current_node.obj[:]

            pq.put(new_node)

    while current_node is not None:
        path.append(current_node.location)
        current_node = current_node.parent

    return path[::-1]

    ############################################################################
