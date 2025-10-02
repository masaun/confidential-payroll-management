use crate::tests::token_helper::{self, mint_amount};
//use crate::Token;
use dep::token::Token;
use aztec::{note::constants::MAX_NOTES_PER_PAGE, test::helpers::authwit as authwit_cheatcodes};
use uint_note::uint_note::UintNote;


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
    token_helper::check_private_balance(token_contract_address, owner, mint_amount - transfer_amount);
    token_helper::check_private_balance(token_contract_address, recipient, transfer_amount);
}