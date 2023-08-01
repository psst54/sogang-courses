from util import manhattanDistance
from game import Directions
import random, util

from game import Agent

## Example Agent
class ReflexAgent(Agent):
    def Action(self, gameState):
        move_candidate = gameState.getLegalActions()

        scores = [self.reflex_agent_evaluationFunc(gameState, action) for action in move_candidate]
        bestScore = max(scores)
        Index = [index for index in range(len(scores)) if scores[index] == bestScore]
        get_index = random.choice(Index)

        return move_candidate[get_index]

    def reflex_agent_evaluationFunc(self, currentGameState, action):

        successorGameState = currentGameState.generatePacmanSuccessor(action)
        newPos = successorGameState.getPacmanPosition()
        oldFood = currentGameState.getFood()
        newGhostStates = successorGameState.getGhostStates()
        newScaredTimes = [ghostState.scaredTimer for ghostState in newGhostStates]

        return successorGameState.getScore()


def scoreEvalFunc(currentGameState):

    return currentGameState.getScore()


class AdversialSearchAgent(Agent):
    def __init__(self, getFunc="scoreEvalFunc", depth="2"):
        self.index = 0
        self.evaluationFunction = util.lookup(getFunc, globals())

        self.depth = int(depth)


class MinimaxAgent(AdversialSearchAgent):
    """
    [문제 01] MiniMax의 Action을 구현하시오. (20점)
    (depth와 evaluation function은 위에서 정의한 self.depth and self.evaluationFunction을 사용할 것.)
    """

    def Action(self, gameState):
        ####################### Write Your Code Here ################################

        MAX_VALUE = 987654321
        MIN_VALUE = -987654321

        # move of player
        def max_agent(state, depth, agent_idx):
            if depth == self.depth or state.isWin() or state.isLose():
                return self.evaluationFunction(state)

            move_candidate = state.getLegalActions()
            max_value = MIN_VALUE

            for action in move_candidate:
                max_value = max(
                    max_value, min_agent(state.generateSuccessor(0, action), depth, agent_idx + 1)
                )

            return max_value

        # move of ghost
        def min_agent(state, depth, agent_idx):
            if state.isWin() or state.isLose():
                return self.evaluationFunction(state)

            min_value = MAX_VALUE
            move_candidate = state.getLegalActions(agent_idx)

            if agent_idx < state.getNumAgents() - 1:
                for action in move_candidate:
                    min_value = min(
                        min_value,
                        min_agent(state.generateSuccessor(agent_idx, action), depth, agent_idx + 1),
                    )
            else:
                for action in move_candidate:
                    min_value = min(
                        min_value,
                        max_agent(state.generateSuccessor(agent_idx, action), depth + 1, 0),
                    )

            return min_value

        move_candidate = gameState.getLegalActions()
        move = Directions.STOP
        max_value = MIN_VALUE

        for action in move_candidate:
            cur_value = min_agent(gameState.generateSuccessor(0, action), 0, 1)
            if cur_value > max_value:
                max_value = cur_value
                move = action
        return move

        ############################################################################


class AlphaBetaAgent(AdversialSearchAgent):

    """
    [문제 02] AlphaBeta의 Action을 구현하시오. (25점)
    (depth와 evaluation function은 위에서 정의한 self.depth and self.evaluationFunction을 사용할 것.)
    """

    def Action(self, gameState):
        ####################### Write Your Code Here ################################

        MAX_VALUE = 987654321
        MIN_VALUE = -987654321

        def max_agent(state, depth, alpha, beta):
            if depth == self.depth or state.isWin() or state.isLose():
                return self.evaluationFunction(state)
            max_value = MIN_VALUE
            move_candidate = state.getLegalActions()

            for action in move_candidate:
                max_value = max(
                    max_value, min_agent(state.generateSuccessor(0, action), depth, 1, alpha, beta)
                )
                if max_value > beta:
                    return max_value
                alpha = max(alpha, max_value)
            return max_value

        def min_agent(state, depth, agent_idx, alpha, beta):
            if depth == self.depth or state.isWin() or state.isLose():
                return self.evaluationFunction(state)
            min_value = MAX_VALUE
            move_candidate = state.getLegalActions(agent_idx)
            if agent_idx == state.getNumAgents() - 1:
                for action in move_candidate:
                    min_value = min(
                        min_value,
                        max_agent(
                            state.generateSuccessor(agent_idx, action), depth + 1, alpha, beta
                        ),
                    )
                    if min_value < alpha:
                        return min_value
                    beta = min(beta, min_value)
            else:
                for action in move_candidate:
                    min_value = min(
                        min_value,
                        min_agent(
                            state.generateSuccessor(agent_idx, action),
                            depth,
                            agent_idx + 1,
                            alpha,
                            beta,
                        ),
                    )
                    if min_value < alpha:
                        return min_value
                    beta = min(beta, min_value)
            return min_value

        move_candidate = gameState.getLegalActions()
        move = Directions.STOP
        max_value = MIN_VALUE
        alpha = MAX_VALUE
        beta = MIN_VALUE
        for action in move_candidate:
            cur_value = min_agent(gameState.generateSuccessor(0, action), 0, 1, alpha, beta)
            if cur_value > max_value:
                max_value = cur_value
                move = action
            alpha = max(alpha, max_value)

        return move
        # raise Exception("Not implemented yet")

        ############################################################################


class ExpectimaxAgent(AdversialSearchAgent):
    """
    [문제 03] Expectimax의 Action을 구현하시오. (25점)
    (depth와 evaluation function은 위에서 정의한 self.depth and self.evaluationFunction을 사용할 것.)
    """

    def Action(self, gameState):
        ####################### Write Your Code Here ################################

        MAX_VALUE = 987654321
        MIN_VALUE = -987654321

        def maximizer(state, depth):
            if depth == self.depth or state.isWin() or state.isLose():
                return self.evaluationFunction(state)

            value = MIN_VALUE
            move_candidate = state.getLegalActions()
            for action in move_candidate:
                value = max(value, expecter(state.generateSuccessor(0, action), depth, 1))
            return value

        def expecter(state, depth, agent_idx):
            if depth == self.depth or state.isWin() or state.isLose():
                return self.evaluationFunction(state)

            value = 0
            move_candidate = state.getLegalActions(agent_idx)
            if agent_idx == state.getNumAgents() - 1:
                for action in move_candidate:
                    value += maximizer(state.generateSuccessor(agent_idx, action), depth + 1)
            else:
                for action in move_candidate:
                    value += expecter(
                        state.generateSuccessor(agent_idx, action), depth, agent_idx + 1
                    )
            return value / len(move_candidate)

        move_candidate = gameState.getLegalActions()
        move = Directions.STOP
        value = MIN_VALUE

        for action in move_candidate:
            temp = expecter(gameState.generateSuccessor(0, action), 0, 1)
            if temp > value:
                value = temp
                move = action

        return move

        # raise Exception("Not implemented yet")

        ############################################################################
