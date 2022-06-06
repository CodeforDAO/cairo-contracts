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