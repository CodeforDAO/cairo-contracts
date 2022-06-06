# SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

#
# Storage
#
@storage_var
func contracts_addresses(contract_type: ContractType) -> (addr: felt):
end

#
# Initializer
#
@constructor
func constructor{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(
        timelock_delay: felt,
        membership_address: felt,
        share_address: felt
    ):
    return ()
end

#
# Externals
#

@external
func vestingShare{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(uri: felt, shareRatio: felt):
    Ownable.assert_only_owner()
    return ()
end

@external
func updateInvestmentSettings{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(settings: felt):
    Ownable.assert_only_owner()
    return ()
end

@external
func updateShareSplit{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(share_split: felt):
    Ownable.assert_only_owner()
    return ()
end

@external
func invest{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(amount: felt):
    check_investment_enabled()
    Ownable.assert_only_owner()
    return ()
end

@external
func investInERC20{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(amount: felt):
    check_investment_enabled()
    Ownable.assert_only_owner()
    return ()
end

@external
func pullModulePayment{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(amount: felt):
    Ownable.assert_only_owner()
    return ()
end

@external
func approveModulePayment{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr
    }(amount: felt):
    Ownable.assert_only_owner()
    return ()
end