use crate::{
    Dripper,
    tests::token_helper::{self, mint_amount} // @dev - "mint_amount" is defined as a "global" variable in the token_helper.nr
};

//use crate::Token;
use dep::token::Token;
use aztec::{
    test::helpers::test_environment::TestEnvironment,
    protocol_types::{address::AztecAddress, storage::map::derive_storage_slot_in_map},
    note::constants::MAX_NOTES_PER_PAGE, 
    test::helpers::authwit as authwit_cheatcodes
};
use uint_note::uint_note::UintNote;


/**
 * @notice - Tests for the drip_to_public() in the Dripper contract
 */
#[test]
unconstrained fn test_drip_to_public() {
    let (env, dripper_contract_address, token_contract_address, owner, _user) =
        crate::tests::utils::setup_contract(true);
    let dripper = Dripper::at(dripper_contract_address);

    // Drip to public
    let drip_amount = 5000u64;
    let drip_to_public_call_interface =
        dripper.drip_to_public(token_contract_address, drip_amount);
    drip_to_public_call_interface.call(env);

    // Check public balance
    token_helper::check_public_balance(
        env,
        token_contract_address,
        owner,
        drip_amount as u128,
    );
}

/**
 * @notice - Tests for the drip_to_private() in the Dripper contract
 */
#[test]
unconstrained fn test_drip_to_private() {
    let (mut env, dripper_contract_address, token_contract_address, owner, _user) =
        crate::tests::utils::setup_contract(true);

    let dripper = Dripper::at(dripper_contract_address);

    // Drip to private
    let drip_amount = 5000u64;
    let drip_to_private_call_interface =
        dripper.drip_to_private(token_contract_address, drip_amount);
    drip_to_private_call_interface.call(&mut env.private());

    // Check private balance
    token_helper::check_private_balance(
        env,
        token_contract_address,
        owner,
        drip_amount as u128,
    );
}


/**
 * @notice - transfer_private_on_behalf_of_other() in the Token contract
 */
#[test]
unconstrained fn transfer_private_on_behalf_of_other() {
    // Setup with account contracts. Slower since we actually deploy them, but needed for authwits.
    let (env, token_contract_address, owner, recipient) =
        token_helper::setup_and_mint_to_private_without_minter(true);
    // Add authwit
    let transfer_amount = (1000 as u128);
    let transfer_private_from_call_interface = Token::at(token_contract_address)
        .transfer_private_to_private(owner, recipient, transfer_amount, 1);
    
    authwit_cheatcodes::add_private_authwit_from_call_interface(
        owner,
        recipient,
        transfer_private_from_call_interface,
    );

    // Impersonate recipient to perform the call
    //env.impersonate(recipient);
    
    // Transfer tokens
    //transfer_private_from_call_interface.call(&mut env.private());
    env.call_private(
        recipient,
        transfer_private_from_call_interface,
    );

    // Check balances
    token_helper::check_private_balance(env, token_contract_address, owner, mint_amount - transfer_amount);
    token_helper::check_private_balance(env, token_contract_address, recipient, transfer_amount);
}