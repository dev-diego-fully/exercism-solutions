"""
Module for checking if brackets in a string are properly paired and nested.
"""

import re


def is_paired(input_string: str) -> bool:
    """
    Determines if all brackets in the input string are properly paired and nested.

    Args:
        input_string (str): The string to check for balanced brackets.

    Returns:
        bool: True if brackets are properly paired and nested, False otherwise.
    """
    stack = []
    return (
        all(_to_stack(stack, bracket) for bracket in _only_brackets(input_string))
        and len(stack) == 0
    )


def _only_brackets(input_string: str) -> str:
    """
    Filters the input string, returning only bracket characters.

    Args:
        input_string (str): The string to filter.

    Returns:
        str: A string containing only bracket characters.
    """
    return re.sub(_brackets_pattern, "", input_string)


def _to_stack(stack: list, bracket: str) -> bool:
    """
    Updates the stack based on the current bracket.

    Args:
        stack (list): The stack of open brackets.
        bracket (str): The current bracket to process.

    Returns:
        bool: True if the operation succeeds, False if it fails due to mismatched brackets.
    """
    if bracket in _opener_brackets:
        stack.append(bracket)
        return True
    if len(stack) == 0:
        return False
    if _closer_for[stack[-1]] == bracket:
        stack.pop()
        return True
    return False


_opener_brackets: str = "{(["
_closer_for: dict = {"[": "]", "(": ")", "{": "}"}
_brackets_pattern: str = r"[^\[\]\{\}\(\)]"
