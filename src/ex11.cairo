// ######## Ex 11
// # Importing functions
// In this exercise, you need to:
// - Read this contract and understand how it imports functions from another contract
// - Find the relevant contract it imports from
// - Read the code and understand what is expected of you

#[contract]
mod Ex11 {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use starknet::ContractAddressZeroable;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;
    use integer::u256_from_felt252;
    use hash::LegacyHash;

    // Internal Imports
    use starknet_cairo_101::utils::ex11_base::Ex11Base::tderc20_address;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::has_validated_exercise;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::distribute_points;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::validate_exercise;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::ex_initializer;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::validate_answers;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::ex11_secret_value;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::secret_value;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;

    ////////////////////////////////
    // Constructor
    ////////////////////////////////
    #[constructor]
    fn constructor(
        _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: u128, _exercise_id: u128
    ) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    ////////////////////////////////
    // EXTERNAL FUNCTIONS
    ////////////////////////////////

    #[external]
    fn claim_points(secret_value_i_guess: u128, next_secret_value_i_chose: u128) {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Check if your answer is correct
        validate_answers(sender_address, secret_value_i_guess, next_secret_value_i_chose);
        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt252(2));
    }

    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }
}
