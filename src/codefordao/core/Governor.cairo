# SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

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