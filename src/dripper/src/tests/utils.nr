use crate::Dripper;
use aztec::{
    //prelude::AztecAddress, 
    protocol_types::{
        contract_instance::ContractInstance,
        address::AztecAddress, // @dev - aztec v2.0.3
    },
    test::helpers::test_environment::TestEnvironment,
};

pub unconstrained fn setup_contract(
    with_account_contracts: bool,
) -> (&mut TestEnvironment, AztecAddress, AztecAddress, AztecAddress) {
    // Setup env, generate keys
    let mut env = TestEnvironment::new();
    let (owner, user) = if with_account_contracts {
        let owner = env.create_contract_account();
        let user = env.create_contract_account();
        (owner, user)
    } else {
        let owner = env.create_light_account();
        let user = env.create_light_account();
        (owner, user)
    };

    // @dev - deploy the Dripper contract
    let dripper_contract = deploy_dripper_contract(&mut env, owner);

    // @dev - deploy the Token contract
    let initial_supply = 1_000_000u128;
    let token_contract_address = token_helper::deploy_token_with_initial_supply(&mut env, owner, initial_supply, user);

    (&mut env, dripper_contract.to_address(), token_contract_address, owner, user)
}

pub unconstrained fn deploy_dripper_contract(
    env: &mut TestEnvironment,
    owner: AztecAddress,
) -> ContractInstance {
    let initializer_call_interface = Dripper::interface().constructor();
    let contract_instance = env
        .deploy("Dripper")
        .with_public_initializer(owner, initializer_call_interface);
    
    env.mine_block();

    contract_instance
}