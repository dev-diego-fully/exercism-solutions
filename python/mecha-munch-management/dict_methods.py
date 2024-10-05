"""Functions to manage a users shopping cart items."""


def add_item(current_cart, items_to_add):
    """Add items to shopping cart.

    :param current_cart: dict - the current shopping cart.
    :param items_to_add: iterable - items to add to the cart.
    :return: dict - the updated user cart dictionary.
    """
    items = set(items_to_add)
    for item in items:
        prev = current_cart[item] if item in current_cart else 0
        current_cart[item] = prev + items_to_add.count(item)
    return current_cart


def read_notes(notes):
    """Create user cart from an iterable notes entry.

    :param notes: iterable of items to add to cart.
    :return: dict - a user shopping cart dictionary.
    """
    return dict.fromkeys(notes, 1)


def update_recipes(ideas, recipe_updates):
    """Update the recipe ideas dictionary.

    :param ideas: dict - The "recipe ideas" dict.
    :param recipe_updates: dict - dictionary with updates for the ideas section.
    :return: dict - updated "recipe ideas" dict.
    """
    new_recipe = ideas.copy()
    new_recipe.update(recipe_updates)
    return new_recipe


def sort_entries(cart):
    """Sort a users shopping cart in alphabetically order.

    :param cart: dict - a users shopping cart dictionary.
    :return: dict - users shopping cart sorted in alphabetical order.
    """
    sorted_items = sorted(cart.keys())
    sorted_cart = {}
    for item in sorted_items:
        sorted_cart[item] = cart[item]
    return sorted_cart


def send_to_store(cart, aisle_mapping):
    """Combine users order to aisle and refrigeration information.

    :param cart: dict - users shopping cart dictionary.
    :param aisle_mapping: dict - aisle and refrigeration information dictionary.
    :return: dict - fulfillment dictionary ready to send to store.
    """
    store_map = {}
    for key in sorted(cart.keys(), reverse=True):
        amount, [aisle, needs_regrigeration] = cart[key], aisle_mapping[key]
        store_map[key] = [amount, aisle, needs_regrigeration]
        print(store_map[key])
    return store_map


def update_store_inventory(fulfillment_cart, store_inventory):
    """Update store inventory levels with user order.

    :param fulfillment cart: dict - fulfillment cart to send to store.
    :param store_inventory: dict - store available inventory
    :return: dict - store_inventory updated.
    """
    for item in fulfillment_cart.keys():
        cart_amount, aisle, needs_regrigeration = fulfillment_cart[item]
        store_amount, _, _ = store_inventory[item]
        new_amount = store_amount - cart_amount
        if new_amount <= 0:
            new_amount = 'Out of Stock'
        store_inventory[item] = [new_amount, aisle, needs_regrigeration]
    return store_inventory
