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
        let owner = env.create_contract_account(1);
        let user = env.create_contract_account(2);
        (owner, user)
    } else {
        let owner = env.create_light_account(1);
        let user = env.create_light_account(2);
        (owner, user)
    };

    let acontract = deploy_contract(&mut env, owner);

    (&mut env, acontract.to_address(), owner, user)
}

pub unconstrained fn deploy_contract(
    env: &mut TestEnvironment,
    owner: AztecAddress,
) -> ContractInstance {
    let initializer_call_interface = Dripper::interface().constructor();
    let contract_instance = env
        .deploy("./@dripper_contract", "Dripper")
        .with_public_void_initializer(owner, initializer_call_interface);
    env.mine_block();

    contract_instance
}