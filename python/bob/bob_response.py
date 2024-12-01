"""
Defines the BobResponse class and the logic for Bob's programmed responses.

This module includes the structure for Bob's responses and a factory function
to generate a dictionary of programmed responses based on specific triggers.
"""

from typing import Callable
from bob_regexing import get_patterns, regex_check

__patterns = get_patterns()


def get_programmed_responses() -> dict:
    """
    Constructs a dictionary of Bob's programmed responses.

    Each entry in the dictionary maps a response type (e.g., 'silence',
    'yelling') to a BobResponse object that contains the response content
    and its trigger logic.

    :return: dict a mapping of response types to BobResponse objects
    """
    return {
        "silence": BobResponse(
            "Fine. Be that way!",
            lambda msg: regex_check(msg, __patterns["silence"]),
        ),
        "yelling questions": BobResponse(
            "Calm down, I know what I'm doing!",
            lambda msg: regex_check(msg, __patterns["yelling"])
            and regex_check(msg, __patterns["question"]),
        ),
        "yelling": BobResponse(
            "Whoa, chill out!", lambda msg: regex_check(msg, __patterns["yelling"])
        ),
        "questions": BobResponse(
            "Sure.", lambda msg: regex_check(msg, __patterns["question"])
        ),
        "default": BobResponse("Whatever.", lambda msg: True),
    }


class BobResponse:
    """
    Represents a programmed response for Bob, including its content and trigger logic.

    Instances of this class define a response message and the logic to determine
    when this response is appropriate based on a given message.
    """

    def __init__(self, content: str, trigger_checker: Callable[[str], bool]):
        """
        Initializes a BobResponse instance.

        :param content: str the response content
        :param trigger_checker: Callable[[str], bool] a function to determine if this
            response is triggered by a given message
        """
        self.__content: str = content
        self.__trigger_checker = trigger_checker

    @property
    def content(self) -> str:
        """
        Returns the content of the response.

        :return: str the response content
        """
        return self.__content

    def is_triggered_by(self, msg: str) -> bool:
        """
        Checks if the response is triggered by the given message.

        :param msg: str the message to evaluate
        :return: bool True if the response is triggered, False otherwise
        """
        return self.__trigger_checker(msg)
