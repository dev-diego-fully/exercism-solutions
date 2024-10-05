namespace hellmath {

// Task 1 - Define an `AccountStatus` enumeration to represent the four
// account types: `troll`, `guest`, `user`, and `mod`.
enum class AccountStatus {
    troll,
    guest,
    user,
    mod
};

// Task 1 - Define an `Action` enumeration to represent the three
// permission types: `read`, `write`, and `remove`.
enum class Action {
    read,
    write,
    remove
};

// Task 2 - Implement the `display_post` function, that gets two arguments
// of `AccountStatus` and returns a `bool`. The first argument is the status of
// the poster, the second one is the status of the viewer.
bool display_post( AccountStatus poster_status, AccountStatus viewer_status ) {

    if( poster_status != AccountStatus::troll )
        return true;
    
    return viewer_status == AccountStatus::troll;

}

// Task 3 - Implement the `permission_check` function, that takes an
// `Action` as a first argument and an `AccountStatus` to check against. It
// should return a `bool`.
bool permission_check( Action action, AccountStatus user_status ) {

    switch (action) {
        case Action::read:
            return true;

        case Action::write:
            return user_status != AccountStatus::guest;

        case Action::remove:
            return user_status == AccountStatus::mod;

        default:
            return false;
    }

}

// Task 4 - Implement the `valid_player_combination` function that
// checks if two players can join the same game. The function has two parameters
// of type `AccountStatus` and returns a `bool`.
bool valid_player_combination( AccountStatus player_a, AccountStatus player_b ) {

    if( player_a == AccountStatus::guest or player_b == AccountStatus::guest )
        return false;

    if( (player_a == AccountStatus::troll) != (player_b == AccountStatus::troll) )
        return false;

    return true;

}


// Task 5 - Implement the `has_priority` function that takes two
// `AccountStatus` arguments and returns `true`, if and only if the first
// account has a strictly higher priority than the second.
bool has_priority( AccountStatus user_a, AccountStatus user_b ) {

    return user_a > user_b;

}

}  // namespace hellmath