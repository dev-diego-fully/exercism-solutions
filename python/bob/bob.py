"""
Main module for Bob's conversational logic.

Defines the response function to determine Bob's reply based on user input.
"""

from bob_response import get_programmed_responses

__programmed_responses = get_programmed_responses()


def response(hey_bob: str) -> str:
    """
    Determines Bob's response based on the input message.

    Iterates through Bob's programmed responses to find a matching trigger. If no
    trigger matches, raises a ValueError.

    :param hey_bob: str the message to evaluate
    :return: str Bob's response
    :raises ValueError: if no programmed response matches the input
    """
    for bob_response in __programmed_responses.values():
        if bob_response.is_triggered_by(hey_bob):
            return bob_response.content
    raise ValueError("Unprogrammed response.")
